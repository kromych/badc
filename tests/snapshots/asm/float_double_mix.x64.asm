
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
               	movl	$0x3dcccccd, %edx       # imm = 0x3DCCCCCD
               	movabsq	$0x3fc999999999999a, %rax # imm = 0x3FC999999999999A
               	movq	%rdx, %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	addsd	%xmm15, %xmm0
               	movabsq	$0x3fd3333334cccccd, %rax # imm = 0x3FD3333334CCCCCD
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3cd203af9ee75616, %rcx # imm = 0x3CD203AF9EE75616
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	retq
               	movabsq	$0x3fb99999a0000000, %rcx # imm = 0x3FB99999A0000000
               	movq	%rcx, %xmm15
               	movapd	%xmm1, %xmm0
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3c670ef54646d497, %rcx # imm = 0x3C670EF54646D497
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x2, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	retq
               	movabsq	$0x3fbf9add3746f62e, %rcx # imm = 0x3FBF9ADD3746F62E
               	movq	%rcx, %xmm14
               	cvtsd2ss	%xmm14, %xmm1
               	movl	$0x3dfcd6ea, %edx       # imm = 0x3DFCD6EA
               	movq	%rdx, %xmm15
               	movapd	%xmm1, %xmm0
               	subss	%xmm15, %xmm0
               	xorq	%rdx, %rdx
               	movq	%rdx, %xmm15
               	ucomiss	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movl	$0x322bcc77, %esi       # imm = 0x322BCC77
               	movq	%rsi, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4008000000000000, %rcx # imm = 0x4008000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	divsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0x3eaaaaab, %eax       # imm = 0x3EAAAAAB
               	movq	%rax, %xmm15
               	subss	%xmm15, %xmm0
               	movq	%rdx, %xmm15
               	ucomiss	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movl	$0x33d6bf95, %eax       # imm = 0x33D6BF95
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x5, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	cvtss2sd	%xmm1, %xmm0
               	movq	%rcx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movabsq	$0x3e112e0be826d695, %rcx # imm = 0x3E112E0BE826D695
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
