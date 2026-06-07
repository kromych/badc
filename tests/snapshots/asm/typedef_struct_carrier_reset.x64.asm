
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %r8
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	cmpq	$0xa, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%r8, %rsi
               	movl	%edx, (%rsi)
               	movq	%r8, %rsi
               	addq	$0x28, %rsi
               	movslq	%eax, %rdi
               	movq	%rdi, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rsi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdx
               	movl	%edx, (%rsi)
               	movslq	%ecx, %rcx
               	movslq	%eax, %rdx
               	shlq	$0x2, %rdx
               	movq	%r8, %rsi
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rdi
               	movq	%r8, %rsi
               	addq	$0x28, %rsi
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rdx
               	addq	%rdx, %rdi
               	movslq	%edi, %rdx
               	addq	%rdx, %rcx
               	jmp	<addr>
               	movq	%r8, %rax
               	addq	$0xa0, %rax
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rax)
               	addq	$0xa0, %r8
               	movslq	(%r8), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	leaq	-0xa8(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rcx
               	addq	$0x14, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rcx
               	addq	$0x3c, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	addq	$0xa0, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
