
mem2reg_unsigned_narrow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	leaq	0x2(%rcx), %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	0x4(%rcx), %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	leaq	0x8(%rcx), %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
