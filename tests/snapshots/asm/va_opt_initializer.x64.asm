
va_opt_initializer.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	leaq	0x8(%rsi), %rdx
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	leaq	0x8(%rdi), %rdx
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpl	$0x1, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	leaq	0x8(%rdi), %rdx
               	movslq	%eax, %rcx
               	movq	(%rdx,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpl	$0x2, %ecx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x62, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	(%rsi), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x27(%rcx), %rax
               	subq	$0x2, %rax
               	movslq	%eax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
