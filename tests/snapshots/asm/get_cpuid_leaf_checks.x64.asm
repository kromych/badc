
get_cpuid_leaf_checks.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	cpuid
               	orq	%rbx, %rcx
               	orq	%rdx, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	jae	<addr>
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$-0x1, %eax
               	jae	<addr>
               	xorl	%eax, %eax
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	jae	<addr>
               	xorl	%eax, %eax
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x7, %eax
               	jae	<addr>
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	cpuid
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x7, %eax
               	jae	<addr>
               	xorl	%eax, %eax
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	cpuid
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x7, %eax
               	xorl	%ecx, %ecx
               	cpuid
               	movl	$0x1, %esi
               	jmp	<addr>
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	xorl	%ecx, %ecx
               	cpuid
               	jmp	<addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	cpuid
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7fffffff, %eax       # imm = 0x7FFFFFFF
               	cpuid
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
