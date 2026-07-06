
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
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
