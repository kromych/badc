
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
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
               	addq	%rdi, %rsi
               	movl	%edx, (%rsi)
               	movq	%rdi, %rdx
               	addq	$0x28, %rdx
               	movslq	%eax, %rsi
               	movq	%rsi, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdx
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%rdx)
               	movslq	%ecx, %rcx
               	movslq	%eax, %rdx
               	shlq	$0x2, %rdx
               	movq	%rdi, %rsi
               	addq	%rdx, %rsi
               	movslq	(%rsi), %rsi
               	movq	%rdi, %r8
               	addq	$0x28, %r8
               	addq	%r8, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdi, %rax
               	addq	$0xa0, %rax
               	movslq	%ecx, %rcx
               	movl	%ecx, (%rax)
               	movq	%rdi, %rax
               	addq	$0xa0, %rax
               	movslq	(%rax), %rax
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
               	leaq	-0xa8(%rbp), %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	addq	$0x3c, %rax
               	movslq	(%rax), %rax
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
