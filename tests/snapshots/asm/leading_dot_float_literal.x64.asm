
leading_dot_float_literal.x64:	file format elf64-x86-64

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
               	movl	$0x3f000000, %eax       # imm = 0x3F000000
               	movabsq	$0x3fd0000000000000, %rcx # imm = 0x3FD0000000000000
               	movabsq	$0x4039000000000000, %rdx # imm = 0x4039000000000000
               	movl	$0x1, %esi
               	xorl	%edi, %edi
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	cmovneq	%rdi, %rsi
               	cmovpq	%rdi, %rsi
               	xorl	%edi, %edi
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rsi, %rcx
               	cmovneq	%rdi, %rcx
               	cmovpq	%rdi, %rcx
               	xorl	%esi, %esi
               	movq	%rdx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rsi, %rcx
               	cmovpq	%rsi, %rcx
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
