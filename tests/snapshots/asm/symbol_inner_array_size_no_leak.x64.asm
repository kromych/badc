
symbol_inner_array_size_no_leak.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%esi, %rsi
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r8
               	cmpq	%rsi, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	movq	%r9, %r11
               	shlq	$0x1, %r11
               	addq	%rdi, %r11
               	movl	$0x3, %r10d
               	imulq	%r10, %r9
               	movslq	%r9d, %r9
               	movswq	%r9w, %r9
               	movw	%r9w, (%r11)
               	jmp	<addr>
               	subq	$0x1, %rsi
               	movslq	%esi, %rsi
               	shlq	$0x1, %rsi
               	addq	%rsi, %rdi
               	movswq	(%rdi), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x1, %esi
               	movq	%rsi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movswq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x30(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rsi
               	addq	$0xe, %rsi
               	movswq	(%rsi), %rsi
               	cmpq	$0x15, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rsi
               	addq	$0xe, %rsi
               	movl	$0x63, %eax
               	movw	%ax, (%rsi)
               	leaq	-0x28(%rbp), %rdi
               	addq	$0xe, %rdi
               	movswq	(%rdi), %rdi
               	cmpq	$0x63, %rdi
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
