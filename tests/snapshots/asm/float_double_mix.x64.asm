
float_double_mix.x64:	file format elf64-x86-64

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
               	movabsq	$0x3fc999999999999a, %rax # imm = 0x3FC999999999999A
               	movabsq	$0x3fb99999a0000000, %rcx # imm = 0x3FB99999A0000000
               	movq	%rcx, %xmm14
               	movq	%rax, %xmm15
               	vaddsd	%xmm15, %xmm14, %xmm0
               	movabsq	$0x3fd3333334cccccd, %rax # imm = 0x3FD3333334CCCCCD
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3cd203af9ee75616, %rdx # imm = 0x3CD203AF9EE75616
               	movq	%rdx, %xmm15
               	comisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x1, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	vsubsd	%xmm15, %xmm14, %xmm0
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3c670ef54646d497, %rcx # imm = 0x3C670EF54646D497
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x2, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	movabsq	$0x3fbf9add3746f62e, %rdx # imm = 0x3FBF9ADD3746F62E
               	movl	$0x3dfcd6ea, %ecx       # imm = 0x3DFCD6EA
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	vsubss	%xmm15, %xmm14, %xmm0
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	comiss	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movl	$0x322bcc77, %esi       # imm = 0x322BCC77
               	movq	%rsi, %xmm15
               	comiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x3, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4008000000000000, %rdx # imm = 0x4008000000000000
               	movq	%rax, %xmm14
               	movq	%rdx, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0x3eaaaaab, %eax       # imm = 0x3EAAAAAB
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	comiss	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movl	$0x33d6bf95, %eax       # imm = 0x33D6BF95
               	movq	%rax, %xmm15
               	comiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x5, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$0x3fbf9add40000000, %rsi # imm = 0x3FBF9ADD40000000
               	movq	%rsi, %xmm14
               	movq	%rdx, %xmm15
               	vsubsd	%xmm15, %xmm14, %xmm0
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rdx # imm = 0x3E112E0BE826D695
               	movq	%rdx, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
