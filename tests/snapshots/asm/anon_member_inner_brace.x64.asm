
anon_member_inner_brace.x64:	file format elf64-x86-64

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
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x7, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq
