
switch_multilabel.x64:	file format elf64-x86-64

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

<classify>:
               	cmpl	$0x42, %edi
               	jl	<addr>
               	cmpl	$0x62, %edi
               	jl	<addr>
               	cmpl	$0x63, %edi
               	jl	<addr>
               	cmpl	$0x64, %edi
               	jl	<addr>
               	cmpl	$0x64, %edi
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	cmpl	$0x61, %edi
               	jl	<addr>
               	jmp	<addr>
               	cmpl	$0x42, %edi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x32, %edi
               	jl	<addr>
               	cmpl	$0x33, %edi
               	jl	<addr>
               	cmpl	$0x41, %edi
               	jl	<addr>
               	jmp	<addr>
               	cmpl	$0x33, %edi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	jmp	<addr>
               	cmpl	$0x31, %edi
               	jl	<addr>
               	jmp	<addr>
               	cmpl	$0x30, %edi
               	je	<addr>
               	jmp	<addr>

<main>:
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	retq
