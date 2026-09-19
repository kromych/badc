
static_neg_infinity_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movsd	(%rcx), %xmm0
               	movabsq	$0x7fe1ccf385ebc8a0, %rdx # imm = 0x7FE1CCF385EBC8A0
               	movq	%rdx, %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	xorl	%eax, %eax
               	testq	%rsi, %rsi
               	je	<addr>
               	movapd	%xmm0, %xmm2
               	addsd	%xmm0, %xmm2
               	ucomisd	%xmm0, %xmm2
               	sete	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rsi
               	movsd	0x8(%rsi), %xmm0
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movapd	%xmm0, %xmm2
               	addsd	%xmm0, %xmm2
               	ucomisd	%xmm0, %xmm2
               	sete	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rsi
               	movsd	(%rsi), %xmm0
               	ucomisd	%xmm0, %xmm1
               	jbe	<addr>
               	movapd	%xmm0, %xmm1
               	addsd	%xmm0, %xmm1
               	ucomisd	%xmm0, %xmm1
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	movsd	(%rcx), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jb	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
