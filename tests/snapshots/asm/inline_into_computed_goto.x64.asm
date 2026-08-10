
inline_into_computed_goto.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	leaq	-0x18(%rbp), %rcx
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx        # <addr>
               	movq	%rdx, 0x10(%rcx)
               	movq	%rax, -0x28(%rbp)
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	0x10(%rbp), %rdx
               	movslq	%eax, %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, -0x20(%rbp)
               	movslq	(%rdx,%rax,4), %rax
               	movq	(%rcx,%rax,8), %rax
               	jmpq	*%rax
               	movq	-0x28(%rbp), %rsi
               	movq	0x20(%rbp), %rcx
               	movq	0x10(%rbp), %rdx
               	movslq	-0x20(%rbp), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, -0x20(%rbp)
               	movslq	(%rdx,%rax,4), %rax
               	jmp	<addr>
               	addq	%rsi, %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	0x10(%rbp), %rdx
               	movslq	-0x20(%rbp), %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, -0x20(%rbp)
               	movslq	(%rdx,%rax,4), %rax
               	movq	(%rcx,%rax,8), %rax
               	jmpq	*%rax
               	movq	-0x28(%rbp), %rax
               	addq	%rax, %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movq	0x10(%rbp), %rdx
               	movslq	-0x20(%rbp), %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, -0x20(%rbp)
               	movslq	(%rdx,%rax,4), %rax
               	movq	(%rcx,%rax,8), %rax
               	jmpq	*%rax
               	movq	-0x28(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	movq	(%rcx,%rax,8), %rax
               	andq	$-0x4, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
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
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
