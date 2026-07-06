
inline_into_computed_goto.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sr_val>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	andq	$-0x4, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<dbl>:
               	leaq	(%rdi,%rdi), %rax
               	retq

<interp>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, 0x10(%rbp)
               	movq	%rsi, 0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x10(%rax)
               	movq	%rcx, -0x20(%rbp)
               	movl	%ecx, -0x28(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	0x10(%rbp), %rdx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rdx,%rcx,4), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movq	-0x20(%rbp), %rax
               	movq	0x20(%rbp), %rcx
               	movq	0x10(%rbp), %rdx
               	movslq	-0x28(%rbp), %rsi
               	leaq	0x1(%rsi), %rdi
               	movl	%edi, -0x28(%rbp)
               	movslq	(%rdx,%rsi,4), %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	andq	$-0x4, %rcx
               	addq	%rcx, %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movslq	%edi, %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rdx,%rcx,4), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movq	-0x20(%rbp), %rax
               	addq	%rax, %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movq	0x10(%rbp), %rcx
               	movslq	-0x28(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	(%rcx,%rdx,4), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movq	-0x20(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x18(%rbp), %rax
               	movl	$0x67, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xc9, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x12c, %ecx            # imm = 0x12C
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x18(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0x384, %rax            # imm = 0x384
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
