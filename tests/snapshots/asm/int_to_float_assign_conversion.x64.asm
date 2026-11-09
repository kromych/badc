
int_to_float_assign_conversion.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xc22e0a3c, %eax       # imm = 0xC22E0A3C
               	movl	$0xc22c0000, %ecx       # imm = 0xC22C0000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	comiss	%xmm15, %xmm14
               	ja	<addr>
               	movl	$0xc2300000, %ecx       # imm = 0xC2300000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	comiss	%xmm14, %xmm15
               	jbe	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x40e00000, %eax       # imm = 0x40E00000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
