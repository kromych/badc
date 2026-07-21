
inline_asm_x64_setjmp_label.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<ctx_jump>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rax, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	%rdi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %rbp
               	movq	0x10(%rax), %r12
               	movq	0x18(%rax), %rdx
               	movq	0x20(%rax), %r13
               	movq	0x28(%rax), %r14
               	movq	%rdx, %rsp
               	movq	0x30(%rax), %r15
               	movq	0x38(%rax), %rdx
               	jmpq	*%rdx
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rdx
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<deep_touch>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movslq	%edi, %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdx
               	leaq	(%rdx,%rcx), %r8
               	leaq	(%rdi,%rcx), %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
               	jl	<addr>
               	testq	%rdi, %rdi
               	jle	<addr>
               	decq	%rdi
               	callq	<addr>
               	leaq	-0x100(%rbp), %rax
               	xorq	%rcx, %rcx
               	movsbq	(%rax), %rax
               	movq	%rcx, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rbx
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%r8, -0x48(%rbp)
               	movq	%r9, -0x40(%rbp)
               	movq	%r10, -0x38(%rbp)
               	movq	%r11, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rbx, -0x20(%rbp)
               	movq	-0x20(%rbp), %rdx
               	leaq	<rip>, %rcx        # <addr>
               	xorq	%rax, %rax
               	movq	%rbx, (%rdx)
               	movq	%rbp, 0x8(%rdx)
               	movq	%r12, 0x10(%rdx)
               	movq	%rsp, 0x18(%rdx)
               	movq	%r13, 0x20(%rdx)
               	movq	%r14, 0x28(%rdx)
               	movq	%r15, 0x30(%rdx)
               	movq	%rcx, 0x38(%rdx)
               	movq	-0x28(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0x60(%rbp), %rax
               	movq	-0x58(%rbp), %rcx
               	movq	-0x50(%rbp), %rdx
               	movq	-0x48(%rbp), %r8
               	movq	-0x40(%rbp), %r9
               	movq	-0x38(%rbp), %r10
               	movq	-0x30(%rbp), %r11
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
