
const_object_member_fold.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x14, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x30ae, %rcx           # imm = 0x30AE
               	je	<addr>
               	movl	$0x2, %eax
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movl	0x8(%rcx), %ecx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	orq	$0x4, %rax
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xc8, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$-0x5, %ecx
               	je	<addr>
               	orq	$0x8, %rax
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x400e000000000000, %rcx # imm = 0x400E000000000000
               	movq	%rax, %rdx
               	orq	$0x10, %rdx
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rdx, %rax
               	cmovpq	%rdx, %rax
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x1020304, %ecx        # imm = 0x1020304
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x6, %ecx
               	je	<addr>
               	orq	$0x20, %rax
               	movl	<rip>, %ecx # <addr>
               	movq	%rax, %rdx
               	orq	$0x40, %rdx
               	cmpl	$0x1e, %ecx
               	cmovneq	%rdx, %rax
               	retq
