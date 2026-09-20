
local_init_int_to_float.x64:	file format elf64-x86-64

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
               	movl	$0x2a, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x4227999a, %eax       # imm = 0x4227999A
               	movq	%rax, %xmm15
               	ucomiss	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x42286666, %eax       # imm = 0x42286666
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x3039, %eax           # imm = 0x3039
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x4640e200, %eax       # imm = 0x4640E200
               	movq	%rax, %xmm15
               	ucomiss	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x4640e600, %eax       # imm = 0x4640E600
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	$-0x7, %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$-0x3fe2000000000000, %rax # imm = 0xC01E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	ja	<addr>
               	movabsq	$-0x3fe6000000000000, %rax # imm = 0xC01A000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movl	$0x4f7fb434, %eax       # imm = 0x4F7FB434
               	movq	%rax, %xmm15
               	ucomiss	%xmm0, %xmm15
               	ja	<addr>
               	movl	$0x4f802666, %eax       # imm = 0x4F802666
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	leaq	<rip>, %rdi
               	cvtss2sd	%xmm0, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x406ccccd, %eax       # imm = 0x406CCCCD
               	movq	%rax, %xmm14
               	cvttss2si	%xmm14, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x3ff8cccccccccccd, %rax # imm = 0xC007333333333333
               	movq	%rax, %xmm14
               	cvttsd2si	%xmm14, %rax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
