
stacked_sign_extend_collapse.x64:	file format elf64-x86-64

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
               	movq	<rip>, %rax # <addr>
               	movsbq	%al, %rcx
               	cmpl	$-0x11, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movswq	%ax, %rax
               	cmpl	$0xffffcdef, %eax       # imm = 0xFFFFCDEF
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$-0x11, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$0xffffcdef, %eax       # imm = 0xFFFFCDEF
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	movl	$0x6, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, <rip> # <addr>
               	cmpq	$-0x1194d800, %rax      # imm = 0xEE6B2800
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorl	%eax, %eax
               	retq
