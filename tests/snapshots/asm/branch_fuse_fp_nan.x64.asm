
branch_fuse_fp_nan.x64:	file format elf64-x86-64

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
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1 # <addr>
               	divsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm1 # <addr>
               	movss	<rip>, %xmm2 # <addr>
               	movss	<rip>, %xmm3 # <addr>
               	divss	%xmm3, %xmm2
               	movss	<rip>, %xmm3 # <addr>
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x1, %eax
               	retq
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x2, %eax
               	retq
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x3, %eax
               	retq
               	comisd	%xmm1, %xmm0
               	jb	<addr>
               	movl	$0x4, %eax
               	retq
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x6, %eax
               	retq
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x9, %eax
               	retq
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0xa, %eax
               	retq
               	comisd	%xmm1, %xmm0
               	jb	<addr>
               	movl	$0xb, %eax
               	retq
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0xc, %eax
               	retq
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	comisd	%xmm1, %xmm0
               	jae	<addr>
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movl	$0x10, %eax
               	retq
               	movsd	<rip>, %xmm0
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movl	$0x12, %eax
               	retq
               	movsd	<rip>, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	comiss	%xmm2, %xmm3
               	jbe	<addr>
               	movl	$0x14, %eax
               	retq
               	comiss	%xmm3, %xmm2
               	jbe	<addr>
               	movl	$0x15, %eax
               	retq
               	comiss	%xmm2, %xmm3
               	jb	<addr>
               	movl	$0x16, %eax
               	retq
               	comiss	%xmm3, %xmm2
               	jb	<addr>
               	movl	$0x17, %eax
               	retq
               	ucomiss	%xmm2, %xmm2
               	jp	<addr>
               	jne	<addr>
               	movl	$0x18, %eax
               	retq
               	ucomiss	%xmm2, %xmm2
               	jp	<addr>
               	je	<addr>
               	movss	<rip>, %xmm0
               	comiss	%xmm3, %xmm0
               	jbe	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1a, %eax
               	retq
               	movl	$0x19, %eax
               	retq
               	movl	$0x13, %eax
               	retq
               	movl	$0x11, %eax
               	retq
               	movl	$0xf, %eax
               	retq
               	movl	$0xe, %eax
               	retq
               	movl	$0xd, %eax
               	retq
               	movl	$0x8, %eax
               	retq
               	movl	$0x7, %eax
               	retq
