
shift_result_type_signedness.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sext>:
               	movslq	%esi, %rsi
               	movl	%edi, %eax
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	pushq	%rcx
               	movq	%rsi, %rcx
               	sarq	%cl, %rax
               	popq	%rcx
               	retq

<main>:
               	movl	$0xfb, %eax
               	movl	$0x18, %ecx
               	movslq	%ecx, %rcx
               	movl	%eax, %eax
               	shlq	%cl, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	sarq	%cl, %rax
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0xff, %eax
               	movl	$0x18, %ecx
               	movslq	%ecx, %rcx
               	movl	%eax, %eax
               	shlq	%cl, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	sarq	%cl, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x80, %eax
               	movl	$0x18, %ecx
               	movslq	%ecx, %rcx
               	movl	%eax, %eax
               	shlq	%cl, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	sarq	%cl, %rax
               	cmpq	$-0x80, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x7f, %eax
               	movl	$0x18, %ecx
               	movslq	%ecx, %rcx
               	movl	%eax, %eax
               	shlq	%cl, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	sarq	%cl, %rax
               	cmpq	$0x7f, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x8000, %eax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movslq	%eax, %rax
               	sarq	$0x10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
