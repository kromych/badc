
int128_overflow_builtin.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<chk>:
               	popq	%r10
               	subq	$0x60, %rsp
               	movq	0x60(%rsp), %rax
               	movq	%rax, 0x50(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	movq	%rcx, %rdx
               	movq	%r8, %rcx
               	movq	%r9, %r8
               	movslq	%edi, %rdi
               	movslq	%edx, %rdx
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movslq	0x60(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	cmpq	%r8, %rdx
               	je	<addr>
               	movslq	0x60(%rbp), %rax
               	incq	%rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq
               	movq	0x8(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movslq	0x60(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	xorq	%rcx, %rcx
               	movl	$0x1, %edi
               	leaq	-0xc0(%rbp), %rsi
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	leaq	-0xc0(%rbp), %rsi
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x4, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	leaq	-0xc0(%rbp), %rsi
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x7, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	xorq	%rcx, %rcx
               	leaq	-0xc0(%rbp), %rsi
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0xa, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	leaq	-0xc0(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rdi, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0xd, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rdi, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	leaq	-0xc0(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movabsq	$-0x7ffffffffffffffe, %rcx # imm = 0x8000000000000002
               	movq	%r8, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x10, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	xorq	%r8, %r8
               	leaq	-0xb0(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%r8, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x13, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r8
               	leaq	-0xb0(%rbp), %rsi
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r8, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x1, %edi
               	movl	$0x16, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rsi
               	movabsq	$-0x2, %r8
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r8, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	xorq	%rdi, %rdi
               	movl	$0x19, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	leaq	-0xb0(%rbp), %rsi
               	movabsq	$-0x1, %r8
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r8, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x1c, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rsi
               	xorq	%r8, %r8
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%r8, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x1, %edi
               	movl	$0x1f, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	leaq	-0xb0(%rbp), %rsi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rdi, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x22, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rdi, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	xorq	%r8, %r8
               	leaq	-0xb0(%rbp), %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%r8, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xb0(%rbp), %rsi
               	movl	$0x25, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	leaq	-0xb0(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	movq	%rdi, 0x8(%rsi)
               	movl	$0x28, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdi, %rcx
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movabsq	$-0x1, %r8
               	leaq	-0xc0(%rbp), %rsi
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r8, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x2b, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x1, %edi
               	movl	$0x2e, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rsi
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x1, %edi
               	movl	$0x31, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rsi
               	xorq	%rcx, %rcx
               	movl	$0x1, %edi
               	movq	%rdi, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x34, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rdi, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	leaq	-0x88(%rbp), %rax
               	movl	$0x7b, %r8d
               	movl	%r8d, (%rax)
               	movl	-0x88(%rbp), %eax
               	leaq	-0x90(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rdi, 0x8(%rsi)
               	movl	$0x37, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdi, %rcx
               	movq	%r8, %r9
               	movq	%rdi, %r8
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	$0x1, %edi
               	leaq	-0x88(%rbp), %rax
               	movl	%ecx, (%rax)
               	leaq	-0x90(%rbp), %rsi
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x3a, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	leaq	-0x88(%rbp), %rax
               	movabsq	$-0x2, %r8
               	movl	%r8d, (%rax)
               	movslq	-0x88(%rbp), %rax
               	leaq	-0x90(%rbp), %rsi
               	movq	%rax, (%rsi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rsi)
               	movabsq	$-0x1, %rcx
               	movl	$0x3d, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	leaq	-0x88(%rbp), %rax
               	movl	%ecx, (%rax)
               	movl	$0x1, %edi
               	leaq	-0x90(%rbp), %rsi
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x40, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	$0x1, %edi
               	leaq	-0x88(%rbp), %rax
               	movabsq	$-0x1, %r8
               	movq	%r8, (%rax)
               	movq	-0x88(%rbp), %rax
               	leaq	-0x90(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x43, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rcx
               	xorq	%rdi, %rdi
               	leaq	-0x98(%rbp), %rax
               	movabsq	$-0xf, %r8
               	movq	%r8, (%rax)
               	movq	-0x98(%rbp), %rax
               	leaq	-0x90(%rbp), %rsi
               	movq	%rax, (%rsi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rsi)
               	movl	$0x46, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	leaq	-0x98(%rbp), %rax
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movq	%r8, (%rax)
               	movq	-0x98(%rbp), %rax
               	leaq	-0x90(%rbp), %rsi
               	movq	%rax, (%rsi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rsi)
               	movabsq	$-0x1, %rcx
               	movl	$0x49, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	leaq	-0xb0(%rbp), %rsi
               	xorq	%rdi, %rdi
               	movq	%r8, (%rsi)
               	movq	%rdi, 0x8(%rsi)
               	movl	$0x4c, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdi, %rcx
               	movq	%r8, %r9
               	movq	%rdi, %r8
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movl	$0x1, %ecx
               	leaq	-0xc0(%rbp), %rsi
               	movq	%rdi, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x4f, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rdi, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	leaq	-0xc0(%rbp), %rsi
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x52, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdi, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
