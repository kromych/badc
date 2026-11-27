
bitnot_promoted_compare.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jae	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jb	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jb	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jae	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jae	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	<rip>, %esi # <addr>
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movb	%al, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$-0x1, %ecx
               	jae	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$-0x1, %ecx
               	jb	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$-0x10, %ecx
               	jae	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$-0x10, %ecx
               	jb	<addr>
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq
