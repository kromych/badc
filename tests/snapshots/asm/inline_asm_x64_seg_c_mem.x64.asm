
inline_asm_x64_seg_c_mem.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movq	%rax, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rcx, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	movq	%fs:0x0, %rax
               	movq	-0x50(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x20(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	$0x8, %ecx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%fs:0x8, %rax
               	movq	-0x50(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x18(%rbp), %rcx
               	movq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	-0x48(%rbp), %rbx
               	movq	%gs:<rip>, %rax
               	movq	-0x50(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0xabcde, %rax          # imm = 0xABCDE
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%gs:<rip>, %rax
               	movq	-0x50(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x13579, %rax          # imm = 0x13579
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1111, %ecx           # imm = 0x1111
               	movq	%rcx, 0x8(%rax)
               	movl	$0x3333, %ecx           # imm = 0x3333
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x9e, %edx
               	movl	$0x1001, %esi           # imm = 0x1001
               	movq	%rcx, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x48(%rbp), %rax
               	movq	-0x40(%rbp), %rdi
               	movq	-0x38(%rbp), %rsi
               	syscall
               	movq	-0x50(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x28(%rbp), %rax
               	movl	$0x8, %ecx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%gs:0x8, %rax
               	movq	-0x50(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x28(%rbp), %rax
               	movl	$0x18, %ecx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	%gs:0x18, %rax
               	movq	-0x50(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x3333, %rax           # imm = 0x3333
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x4444, %eax           # imm = 0x4444
               	movl	$0x28, %ecx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	-0x50(%rbp), %rax
               	movq	%rax, %gs:0x28
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	cmpq	$0x4444, %rax           # imm = 0x4444
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x8, %ecx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movl	%gs:0x8, %eax
               	movq	-0x50(%rbp), %r10
               	movl	%eax, (%r10)
               	movl	-0x10(%rbp), %eax
               	xorq	$0x1111, %rax           # imm = 0x1111
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x9e, %edx
               	movl	$0x1001, %esi           # imm = 0x1001
               	movq	%rcx, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	movq	-0x48(%rbp), %rax
               	movq	-0x40(%rbp), %rdi
               	movq	-0x38(%rbp), %rsi
               	syscall
               	movq	-0x50(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x50(%rbp)
               	movq	%rcx, -0x48(%rbp)
               	movq	<rip>, %rax
               	movq	-0x50(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x28(%rbp), %rax
               	cmpq	$0xabcde, %rax          # imm = 0xABCDE
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
