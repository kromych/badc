
aggregate_conditional_reads_each_word.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<pick_pair>:
               	movl	$0x4, %eax
               	movl	$0x5, %ecx
               	movq	$-0x4, %rdx
               	movq	$-0x5, %rdi
               	testl	%esi, %esi
               	cmoveq	%rdi, %rcx
               	testl	%esi, %esi
               	cmoveq	%rdx, %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	retq

<pick_triple>:
               	movl	$0x2, %edx
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x4, %eax
               	movl	$0x6, %ecx
               	imulq	$0xa, %rax, %rax
               	addq	%rdx, %rax
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	jmp	<addr>

<main>:
               	pushq	%rax
               	movslq	<rip>, %rax # <addr>
               	movl	$0x5, %ecx
               	xorl	%edx, %edx
               	movl	<rip>, %esi # <addr>
               	testl	%esi, %esi
               	cmovlq	%rdx, %rcx
               	xorq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	jl	<addr>
               	movl	$0x4, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x195, %rax            # imm = 0x195
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$-0x195, %rax           # imm = 0xFE6B
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x282, %rax            # imm = 0x282
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movl	$0x2, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	movl	$0x2, %eax
               	popq	%r11
               	retq
