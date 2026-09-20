
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
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x14, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x30ae, %rcx           # imm = 0x30AE
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1e, %ecx
               	je	<addr>
               	orq	$0x4, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0xc8, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$-0x5, %ecx
               	je	<addr>
               	orq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movsd	(%rcx), %xmm0
               	movabsq	$0x400e000000000000, %rcx # imm = 0x400E000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	orq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1020304, %ecx        # imm = 0x1020304
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x6, %ecx
               	je	<addr>
               	orq	$0x20, %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1e, %ecx
               	jne	<addr>
               	retq
               	orq	$0x40, %rax
               	jmp	<addr>
