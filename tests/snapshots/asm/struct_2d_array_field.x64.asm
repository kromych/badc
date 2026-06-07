
struct_2d_array_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rax
               	movq	%rax, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	%ecx, %rsi
               	movq	%rsi, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rax
               	movslq	%edx, %rdi
               	imulq	$0xa, %rsi, %rsi
               	movslq	%esi, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%rax,%rdi,4)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	cmpq	$0x3, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	movslq	%edx, %rax
               	subq	$0x6f, %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %rsi
               	cmpq	$0x4, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edi, %rsi
               	movq	%rsi, %rdi
               	incq	%rdi
               	jmp	<addr>
               	movslq	%edx, %rdx
               	movslq	%ecx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rax, %rsi
               	movslq	%edi, %r8
               	movslq	(%rsi,%r8,4), %rsi
               	addq	%rsi, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
