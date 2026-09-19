
inline_asm_a64_ldr_sub.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	leaq	<rip>, %rax
               	movzwq	0x4(%rax), %rax
               	leaq	<rip>, %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpl	$0x21, %eax
               	jne	<addr>
               	cmpl	$-0x7, %ecx
               	jne	<addr>
               	movl	$0x2a, %eax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
