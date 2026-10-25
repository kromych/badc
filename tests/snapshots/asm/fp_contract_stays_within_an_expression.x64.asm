
fp_contract_stays_within_an_expression.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movsd	(%rax), %xmm0
               	leaq	<rip>, %rax # <addr>
               	movsd	(%rax), %xmm1
               	leaq	<rip>, %rax # <addr>
               	movss	(%rax), %xmm2
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm14
               	vmulss	%xmm2, %xmm14, %xmm2
               	movl	$0x3e99999a, %eax       # imm = 0x3E99999A
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm2
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	vmulsd	%xmm0, %xmm0, %xmm2
               	subsd	%xmm1, %xmm2
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movapd	%xmm1, %xmm2
               	vfmsub231sd	%xmm0, %xmm0, %xmm2 # xmm2 = (xmm0 * xmm0) - xmm2
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	vfmadd213sd	%xmm1, %xmm0, %xmm0 # xmm0 = (xmm0 * xmm0) + xmm1
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	je	<addr>
               	movabsq	$0x3c30000000000000, %rcx # imm = 0x3C30000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movabsq	$0x3c30000000000000, %rcx # imm = 0x3C30000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	retq
