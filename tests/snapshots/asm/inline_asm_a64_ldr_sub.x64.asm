
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
               	movzwq	0x4(%rax), %rcx
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x21, %ecx
               	jne	<addr>
               	cmpl	$-0x7, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
