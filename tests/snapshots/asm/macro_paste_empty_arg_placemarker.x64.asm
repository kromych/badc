
macro_paste_empty_arg_placemarker.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<int32_to_x>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<uint32_to_x>:
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<with_empty_sign>:
               	movl	$0x2, %eax
               	retq

<with_u_sign>:
               	movl	$0x3, %eax
               	retq

<main>:
               	leaq	<rip>, %rcx
               	movl	$0x9, %eax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
