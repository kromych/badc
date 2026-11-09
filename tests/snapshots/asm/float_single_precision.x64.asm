
float_single_precision.x64:	file format elf64-x86-64

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
               	xorl	%ecx, %ecx
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
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	retq
               	movl	$0x3f800001, %eax       # imm = 0x3F800001
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	comiss	%xmm14, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%r11, %xmm0
               	movl	$0x358637bd, %edx       # imm = 0x358637BD
               	movq	%rdx, %xmm15
               	comiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	comiss	%xmm14, %xmm15
               	jbe	<addr>
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	movq	%r11, %xmm0
               	movl	$0x3727c5ac, %eax       # imm = 0x3727C5AC
               	movq	%rax, %xmm15
               	comiss	%xmm15, %xmm0
               	jbe	<addr>
               	movl	$0x4, %eax
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
               	movl	$0x3f800000, %edx       # imm = 0x3F800000
               	movq	%rax, %xmm14
               	movq	%rdx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%r11d, %r11d
               	movq	%r11, %xmm0
               	jmp	<addr>
