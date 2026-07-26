
int128_overflow_builtin.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	movq	(%rax), %rax
               	cmpq	%r8, %rax
               	je	<addr>
               	movslq	0x60(%rbp), %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movslq	0x60(%rbp), %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	subq	$0x4c0, %rsp            # imm = 0x4C0
               	subq	$0x50, %rsp
               	andq	$-0x10, %rsp
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	leaq	0x30(%rsp), %rax
               	xorq	%rsi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x30(%rsp), %rsi
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	leaq	0x30(%rsp), %rax
               	movabsq	$-0x1, %rcx
               	movabsq	$-0x1, %rsi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	xorq	%rdi, %rdi
               	leaq	0x30(%rsp), %rsi
               	movabsq	$-0x1, %rcx
               	movl	$0x4, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	0x30(%rsp), %rax
               	movabsq	$-0x1, %rcx
               	movabsq	$-0x1, %rsi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x30(%rsp), %rsi
               	movabsq	$-0x1, %rcx
               	movl	$0x7, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	xorq	%rcx, %rcx
               	leaq	0x30(%rsp), %rax
               	xorq	%rsi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x30(%rsp), %rsi
               	movl	$0xa, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	leaq	0x30(%rsp), %rax
               	xorq	%rcx, %rcx
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	xorq	%rdi, %rdi
               	leaq	0x30(%rsp), %rsi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0xd, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rdx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	0x30(%rsp), %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movabsq	$-0x7ffffffffffffffe, %rsi # imm = 0x8000000000000002
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x30(%rsp), %rsi
               	movabsq	$-0x7ffffffffffffffe, %rcx # imm = 0x8000000000000002
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movl	$0x10, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	xorq	%r8, %r8
               	leaq	0x40(%rsp), %rax
               	xorq	%rcx, %rcx
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x40(%rsp), %rsi
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movl	$0x13, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r8
               	leaq	0x40(%rsp), %rax
               	movabsq	$-0x1, %rcx
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x40(%rsp), %rsi
               	movl	$0x1, %edx
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x16, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	leaq	0x40(%rsp), %rax
               	movabsq	$-0x2, %rcx
               	movabsq	$0x7fffffffffffffff, %rdx # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	xorq	%rdi, %rdi
               	leaq	0x40(%rsp), %rsi
               	xorq	%rdx, %rdx
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movabsq	$-0x2, %r8
               	movl	$0x19, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	0x40(%rsp), %rax
               	movabsq	$-0x1, %rcx
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x40(%rsp), %rsi
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movabsq	$-0x1, %r8
               	movl	$0x1c, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	leaq	0x40(%rsp), %rax
               	xorq	%r8, %r8
               	xorq	%rcx, %rcx
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x40(%rsp), %rax
               	movl	$0x1, %edx
               	movl	$0x1f, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%r8, %r9
               	movq	%rsi, %r8
               	movq	%rax, %rsi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	leaq	0x40(%rsp), %rax
               	xorq	%rcx, %rcx
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	xorq	%rax, %rax
               	leaq	0x40(%rsp), %rsi
               	movl	$0x22, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%rdx, %r9
               	movq	%rdi, %r8
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	xorq	%r8, %r8
               	leaq	0x40(%rsp), %rax
               	xorq	%rcx, %rcx
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movl	$0x1, %eax
               	leaq	0x40(%rsp), %rsi
               	movl	$0x25, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%r8, %r9
               	movq	%rdi, %r8
               	movq	%rax, %rdi
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	leaq	0x40(%rsp), %rax
               	xorq	%rcx, %rcx
               	xorq	%rsi, %rsi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	xorq	%rdi, %rdi
               	leaq	0x40(%rsp), %rsi
               	movl	$0x28, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%rdx, %r9
               	movq	%rdx, %r8
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movabsq	$-0x1, %r8
               	leaq	0x30(%rsp), %rax
               	movabsq	$-0x1, %rcx
               	movabsq	$0x7fffffffffffffff, %rsi # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	xorq	%rdi, %rdi
               	leaq	0x30(%rsp), %rsi
               	movabsq	$0x7fffffffffffffff, %rcx # imm = 0x7FFFFFFFFFFFFFFF
               	movl	$0x2b, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	leaq	0x30(%rsp), %rax
               	xorq	%rcx, %rcx
               	xorq	%rdx, %rdx
               	xorq	%rsi, %rsi
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x30(%rsp), %rsi
               	movl	$0x1, %edx
               	movl	$0x2e, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	leaq	0x40(%rsp), %rax
               	movabsq	$-0x1, %rcx
               	movabsq	$-0x1, %rdx
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x40(%rsp), %rsi
               	movl	$0x1, %edx
               	movabsq	$-0x1, %rcx
               	movl	$0x31, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	leaq	0x40(%rsp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	xorq	%rsi, %rsi
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	0x40(%rsp), %rsi
               	movl	$0x1, %edx
               	movl	$0x34, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rdx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	leaq	-0x58(%rbp), %rax
               	movl	$0x7b, %ecx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movl	-0x58(%rbp), %eax
               	leaq	-0x390(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rdx, 0x8(%rsi)
               	movl	$0x7b, %r8d
               	movl	$0x37, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%r8, %r9
               	movq	%rdx, %r8
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	leaq	-0x58(%rbp), %rax
               	xorq	%rsi, %rsi
               	movl	%esi, (%rax)
               	movl	$0x1, %edi
               	movl	-0x58(%rbp), %eax
               	leaq	-0x3c0(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movl	$0x3a, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	leaq	-0x60(%rbp), %rax
               	movabsq	$-0x2, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rdi, %rdi
               	movslq	-0x60(%rbp), %rax
               	leaq	-0x3f0(%rbp), %rsi
               	movq	%rax, (%rsi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rsi)
               	movabsq	$-0x1, %rcx
               	movabsq	$-0x2, %r8
               	movl	$0x3d, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	leaq	-0x60(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	movl	$0x1, %edi
               	movslq	-0x60(%rbp), %rax
               	leaq	-0x420(%rbp), %rsi
               	movq	%rax, (%rsi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rsi)
               	movl	$0x1, %edx
               	movl	$0x40, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	$0x1, %edx
               	leaq	-0x68(%rbp), %rax
               	movabsq	$-0x1, %rsi
               	movq	%rsi, (%rax)
               	movl	$0x1, %edi
               	movq	-0x68(%rbp), %rax
               	leaq	-0x450(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movabsq	$-0x1, %r8
               	movl	$0x43, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rcx
               	xorq	%rdx, %rdx
               	leaq	-0x70(%rbp), %rax
               	movabsq	$-0xf, %rsi
               	movq	%rsi, (%rax)
               	xorq	%rdi, %rdi
               	movq	-0x70(%rbp), %rax
               	leaq	-0x480(%rbp), %rsi
               	movq	%rax, (%rsi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rsi)
               	movabsq	$-0xf, %r8
               	movl	$0x46, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	-0x70(%rbp), %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	movq	%rcx, (%rax)
               	movl	$0x1, %edi
               	movq	-0x70(%rbp), %rax
               	leaq	-0x4c0(%rbp), %rsi
               	movq	%rax, (%rsi)
               	sarq	$0x3f, %rax
               	movq	%rax, 0x8(%rsi)
               	movabsq	$-0x1, %rcx
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movl	$0x49, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	leaq	0x40(%rsp), %rax
               	xorq	%rdx, %rdx
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	xorq	%rsi, %rsi
               	xorq	%rdi, %rdi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	0x40(%rsp), %rsi
               	movl	$0x4c, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rdx, %rcx
               	movq	%r8, %r9
               	movq	%rdx, %r8
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movl	$0x1, %ecx
               	leaq	0x30(%rsp), %rax
               	xorq	%rsi, %rsi
               	movl	$0x1, %edi
               	xorq	%r8, %r8
               	movq	%rsi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	leaq	0x30(%rsp), %rsi
               	movl	$0x4f, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%r8, %rdi
               	movq	%rdx, %r9
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	leaq	0x30(%rsp), %rax
               	movabsq	$-0x1, %rcx
               	movabsq	$-0x1, %rsi
               	movl	$0x1, %edi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	0x30(%rsp), %rsi
               	movabsq	$-0x1, %rcx
               	movl	$0x52, %r9d
               	subq	$0x10, %rsp
               	movq	%r9, (%rsp)
               	movq	%rcx, %r8
               	movq	%rcx, %r9
               	movq	%rdx, %rcx
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x10, %rsp
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x4c0(%rbp), %rsp
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
