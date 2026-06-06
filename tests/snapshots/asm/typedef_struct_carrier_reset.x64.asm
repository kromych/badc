
typedef_struct_carrier_reset.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	cmpq	$0xa, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	movq	%rsi, %rdi
               	shlq	$0x2, %rdi
               	addq	%rax, %rdi
               	movl	%esi, (%rdi)
               	movq	%rax, %rsi
               	addq	$0x28, %rsi
               	movslq	%ecx, %rdi
               	movq	%rdi, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rsi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%rsi)
               	movslq	%edx, %rdx
               	movslq	%ecx, %rsi
               	shlq	$0x2, %rsi
               	movq	%rax, %rdi
               	addq	%rsi, %rdi
               	movslq	(%rdi), %rdi
               	movq	%rax, %r8
               	addq	$0x28, %r8
               	addq	%r8, %rsi
               	movslq	(%rsi), %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	addq	$0xa0, %rcx
               	movslq	%edx, %rdx
               	movl	%edx, (%rcx)
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
