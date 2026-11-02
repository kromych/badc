
union_member_unbraced_init.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2b, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2b, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rcx)
               	movsd	-0x18(%rbp), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rcx)
               	movsd	-0x18(%rbp), %xmm0
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x7, %eax
               	leave
               	retq
