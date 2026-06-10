
return_value_in_callee_saved.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<hop_return_n>:
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	retq
               	retq

<hop>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
