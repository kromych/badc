
range_minmax_constant_p_sign.x64:	file format elf64-x86-64

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
               	movl	$0x2710, <rip> # imm = 0x2710
                                                # <addr>
               	movslq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	movl	$0x1000, %edx           # imm = 0x1000
               	cmpq	%rdx, %rax
               	cmovbq	%rax, %rdx
               	addq	%rdx, %rcx
               	subq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpq	$0x2710, %rcx           # imm = 0x2710
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x1, <rip> # <addr>
               	movslq	<rip>, %rax # <addr>
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	movl	$0x1000, %edx           # imm = 0x1000
               	cmpq	%rdx, %rax
               	cmovbq	%rax, %rdx
               	addq	%rdx, %rcx
               	subq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, <rip> # <addr>
               	movslq	<rip>, %rax # <addr>
               	testl	%eax, %eax
               	jle	<addr>
               	movl	$0x1000, %edx           # imm = 0x1000
               	cmpq	%rdx, %rax
               	cmovbq	%rax, %rdx
               	addq	%rdx, %rcx
               	subq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
