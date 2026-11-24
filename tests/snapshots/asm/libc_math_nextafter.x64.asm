
libc_math_nextafter.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	pushq	%rax
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	callq	<addr>
               	movapd	%xmm0, %xmm1
               	movsd	<rip>, %xmm0
               	comisd	%xmm1, %xmm0
               	jb	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	xorps	%xmm1, %xmm1
               	callq	<addr>
               	movapd	%xmm0, %xmm1
               	movsd	<rip>, %xmm0
               	comisd	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movapd	%xmm0, %xmm1
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	callq	<addr>
               	movss	<rip>, %xmm1
               	comiss	%xmm0, %xmm1
               	jb	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
