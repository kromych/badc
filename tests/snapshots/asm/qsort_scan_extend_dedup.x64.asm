
qsort_scan_extend_dedup.x64:	file format elf64-x86-64

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

<qs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movslq	%edx, %r13
               	movslq	%esi, %r8
               	cmpq	%r13, %r8
               	jge	<addr>
               	leaq	(%r8,%r13), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	movslq	(%r12,%rax,4), %rax
               	movq	%r13, %rdx
               	movq	%r8, %rbx
               	jmp	<addr>
               	incq	%rbx
               	movslq	%ebx, %rcx
               	movslq	(%r12,%rcx,4), %rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	movslq	%edx, %rcx
               	movslq	(%r12,%rcx,4), %rcx
               	cmpl	%eax, %ecx
               	jle	<addr>
               	decq	%rdx
               	movslq	%edx, %rcx
               	movslq	(%r12,%rcx,4), %rcx
               	cmpl	%eax, %ecx
               	jg	<addr>
               	cmpl	%edx, %ebx
               	jg	<addr>
               	movslq	%ebx, %rcx
               	movslq	(%r12,%rcx,4), %rsi
               	movslq	%edx, %rdi
               	movslq	(%r12,%rdi,4), %rdi
               	movl	%edi, (%r12,%rcx,4)
               	movslq	%edx, %rcx
               	movl	%esi, (%r12,%rcx,4)
               	incq	%rbx
               	decq	%rdx
               	cmpl	%edx, %ebx
               	jle	<addr>
               	movq	%r12, %rdi
               	movq	%r8, %rsi
               	callq	<addr>
               	movslq	%ebx, %r8
               	cmpq	%r13, %r8
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%rbx
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorl	%eax, %eax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	movl	%ecx, %ecx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %ecx
               	leaq	-0x100(%rbp), %rsi
               	movslq	%eax, %rdi
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	subq	$0x4000, %rdx           # imm = 0x4000
               	movl	%edx, (%rsi,%rdi,4)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x100(%rbp), %rbx
               	xorl	%esi, %esi
               	movl	$0x3f, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x1, %eax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	movslq	(%rbx,%rcx,4), %rsi
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0x1(%rax), %rdx
               	movslq	%edx, %rdx
               	movslq	(%rcx,%rdx,4), %rcx
               	cmpl	%ecx, %esi
               	jl	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
