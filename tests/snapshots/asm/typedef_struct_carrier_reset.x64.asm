
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

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
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	cmpq	$0xa, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%r8)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	movq	%r9, %r11
               	shlq	$0x2, %r11
               	addq	%rdi, %r11
               	movl	%r9d, (%r11)
               	movq	%rdi, %r8
               	addq	$0x28, %r8
               	movslq	-0x8(%rbp), %r11
               	movq	%r11, %r9
               	shlq	$0x2, %r9
               	addq	%r9, %r8
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, (%r8)
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r11
               	movslq	-0x8(%rbp), %r8
               	shlq	$0x2, %r8
               	movq	%rdi, %rsi
               	addq	%r8, %rsi
               	movslq	(%rsi), %rsi
               	movq	%rdi, %rdx
               	addq	$0x28, %rdx
               	addq	%r8, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	movq	%rdi, %rsi
               	addq	$0xa0, %rsi
               	movslq	-0x10(%rbp), %r9
               	movl	%r9d, (%rsi)
               	addq	$0xa0, %rdi
               	movslq	(%rdi), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	-0xa8(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	addq	$0x3c, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	addq	$0xa0, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x4, %edi
               	movq	%rdi, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
