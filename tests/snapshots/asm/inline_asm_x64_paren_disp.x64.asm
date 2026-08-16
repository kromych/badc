
inline_asm_x64_paren_disp.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	leaq	<rip>, %rax         # <addr>
               	jmp	<addr>
               	orl	(%rax), %eax
               	addb	%al, (%rax)
               	<unknown>
               	addb	%al, (%rax)
               	addb	%cl, 0x55(%rbx,%rcx,4)
               	enter	$-0x76b7, $0x2          # imm = 0x8949
               	movq	-0x40(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpq	$0xb, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x4(%rax), %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	leaq	<rip>, %rax         # <addr>
               	jmp	<addr>
               	andl	%eax, (%rax)
               	addb	%al, (%rax)
               	subb	$0x0, %al
               	addb	%al, (%rax)
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x21, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2c, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rax, -0x38(%rbp)
               	jmp	<addr>
               	<unknown>
               	addb	%al, (%rax)
               	addb	%al, (%rdx)
               	addb	%al, (%rax)
               	leaq	-<rip>, %rax        # <addr>
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x37, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	0x4(%rax), %rax
               	cmpq	$0x42, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rbx, -0x38(%rbp)
               	movq	%rcx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movl	0x4(%rbx), %eax
               	movq	-0x30(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rbx
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
