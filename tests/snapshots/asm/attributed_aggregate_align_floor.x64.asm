
attributed_aggregate_align_floor.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x48, %rsp
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	testb	$0xf, %al
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	(%rsp), %rax
               	testb	$0x7, %al
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	movq	$0x7, (%rsp)
               	movq	%rax, 0x8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x48, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x48, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x48, %rsp
               	retq
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$0x31, %ecx
               	jne	<addr>
               	movsbq	<rip>, %rcx # <addr>
               	cmpl	$0x35, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x48, %rsp
               	retq
               	addq	$0x48, %rsp
               	retq
