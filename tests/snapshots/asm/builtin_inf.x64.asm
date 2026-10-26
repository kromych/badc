
builtin_inf.x64:	file format elf64-x86-64

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
               	movabsq	$0x7ff0000000000000, %rax # imm = 0x7FF0000000000000
               	movabsq	$0x7fe1ccf385ebc8a0, %rcx # imm = 0x7FE1CCF385EBC8A0
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x7f800000, %edx       # imm = 0x7F800000
               	movl	$0x7f61b1e6, %esi       # imm = 0x7F61B1E6
               	movq	%rdx, %xmm14
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm14
               	ja	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm14, %xmm15
               	jb	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
