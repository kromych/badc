
clock_monotonic_advances.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x10(%rbp), %r11
               	movabsq	$-0x1, %r9
               	movq	%r9, (%r11)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x8, %r8
               	movq	%r9, (%r8)
               	movl	$0x1, %edi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %esi
               	movq	%rsi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x48(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %rsi
               	addq	$0x8, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$-0x1, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x48(%rbp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	jge	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rsi
               	addq	$0x8, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x0, %rsi
               	setl	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x50(%rbp)
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	setge	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x50(%rbp)
               	jmp	<addr>
               	movq	-0x50(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %esi
               	movq	%rsi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x28(%rbp)
               	movl	%eax, -0x30(%rbp)
               	jmp	<addr>
               	movslq	-0x30(%rbp), %rax
               	cmpq	$0xf4240, %rax          # imm = 0xF4240
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rsi
               	movslq	(%rsi), %rax
               	addq	$0x1, %rax
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	movslq	-0x28(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movl	%eax, -0x28(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	leaq	-0x20(%rbp), %rsi
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movq	(%rdi), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdi
               	jge	<addr>
               	movl	$0x6, %esi
               	movq	%rsi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdi
               	movq	(%rdi), %rdi
               	leaq	-0x10(%rbp), %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	movq	%rdi, -0x58(%rbp)
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	-0x20(%rbp), %rsi
               	addq	$0x8, %rsi
               	movq	(%rsi), %rsi
               	leaq	-0x10(%rbp), %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	setl	%sil
               	movzbq	%sil, %rsi
               	movq	%rsi, -0x58(%rbp)
               	jmp	<addr>
               	movq	-0x58(%rbp), %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x7, %edi
               	movq	%rdi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movq	%rsi, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
