
fnptr_typedef_return_proto.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	retq

<via_proto>:
               	leaq	-<rip>, %rax        # <addr>
               	retq

<pick>:
               	leaq	-<rip>, %rax       # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	-<rip>, %rax       # <addr>
               	movl	$0x14, %edi
               	movl	$0x16, %esi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
