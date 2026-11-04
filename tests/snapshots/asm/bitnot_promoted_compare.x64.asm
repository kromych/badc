
bitnot_promoted_compare.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movb	$0x0, -0x8(%rbp)
               	movl	<rip>, %ecx # <addr>
               	movb	$0x0, -0x8(%rbp)
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rcx, %rax
               	cmpl	%r11d, %ecx
               	jae	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jb	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jb	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jae	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jae	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	<rip>, %esi # <addr>
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	<rip>, %esi # <addr>
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	xorq	$0x3, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	movb	%al, <rip> # <addr>
               	movl	<rip>, %ecx # <addr>
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpl	%r11d, %ecx
               	jae	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movzbq	-0x8(%rbp), %rcx
               	xorq	$-0x1, %rcx
               	shlq	%rcx
               	movl	$0xfffffffe, %r11d      # imm = 0xFFFFFFFE
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	xorq	$-0x1, %rcx
               	movl	%ecx, %ecx
               	shrq	%rcx
               	cmpl	$0x7fffffff, %ecx       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movzbq	-0x8(%rbp), %rcx
               	xorq	$-0x1, %rcx
               	movl	<rip>, %edx # <addr>
               	cmpl	%edx, %ecx
               	ja	<addr>
               	movzbq	-0x8(%rbp), %rcx
               	xorq	$-0x1, %rcx
               	sarq	%rcx
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movb	$0xf, -0x8(%rbp)
               	movl	<rip>, %ecx # <addr>
               	movl	$0xfffffff0, %r11d      # imm = 0xFFFFFFF0
               	cmpl	%r11d, %ecx
               	jae	<addr>
               	movl	<rip>, %ecx # <addr>
               	movl	$0xfffffff0, %r11d      # imm = 0xFFFFFFF0
               	cmpl	%r11d, %ecx
               	jb	<addr>
               	leave
               	retq
               	movl	$0x8, %eax
               	leave
               	retq
