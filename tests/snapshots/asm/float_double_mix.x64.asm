
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
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	comisd	%xmm14, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm0
               	movabsq	$0x3cd203af9ee75616, %rcx # imm = 0x3CD203AF9EE75616
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	comisd	%xmm14, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r11, %xmm0
               	movabsq	$0x3c670ef54646d497, %rcx # imm = 0x3C670EF54646D497
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x2, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	comiss	%xmm14, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%r11, %xmm0
               	movl	$0x322bcc77, %edx       # imm = 0x322BCC77
               	movq	%rdx, %xmm15
               	comiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x3, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	comiss	%xmm14, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%r11, %xmm0
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
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	movabsq	$0x3e217213a4000000, %rdx # imm = 0x3E217213A4000000
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	comisd	%xmm14, %xmm15
               	jbe	<addr>
               	movabsq	$-0x41de8dec5c000000, %r11 # imm = 0xBE217213A4000000
               	movq	%r11, %xmm0
               	movabsq	$0x3e112e0be826d695, %rax # imm = 0x3E112E0BE826D695
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$0x3e217213a4000000, %r11 # imm = 0x3E217213A4000000
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
