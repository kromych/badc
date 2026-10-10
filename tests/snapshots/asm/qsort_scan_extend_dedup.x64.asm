
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
               	cmpl	%edx, %esi
               	jge	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rdx, %r13
               	leaq	(%rsi,%r13), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	movl	(%r12,%rax,4), %eax
               	movq	%r13, %rdx
               	movq	%rsi, %rbx
               	jmp	<addr>
               	incq	%rbx
               	movslq	%ebx, %rcx
               	movl	(%r12,%rcx,4), %edi
               	cmpl	%eax, %edi
               	jl	<addr>
               	movslq	%edx, %rdi
               	movl	(%r12,%rdi,4), %r8d
               	cmpl	%eax, %r8d
               	jle	<addr>
               	decq	%rdx
               	movslq	%edx, %rdi
               	movl	(%r12,%rdi,4), %r8d
               	cmpl	%eax, %r8d
               	jg	<addr>
               	cmpl	%edx, %ebx
               	jg	<addr>
               	movl	(%r12,%rcx,4), %r8d
               	movl	(%r12,%rdi,4), %r9d
               	movl	%r9d, (%r12,%rcx,4)
               	movl	%r8d, (%r12,%rdi,4)
               	incq	%rbx
               	decq	%rdx
               	cmpl	%edx, %ebx
               	jle	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rbx, %rsi
               	cmpl	%r13d, %esi
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%rbx
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorl	%eax, %eax
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	addq	$0x3039, %rcx           # imm = 0x3039
               	leaq	-0x100(%rbp), %rdx
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	subq	$0x4000, %rsi           # imm = 0x4000
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leaq	-0x100(%rbp), %rbx
               	xorl	%esi, %esi
               	movl	$0x3f, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	$0x1, %eax
               	movl	(%rbx,%rax,4), %ecx
               	leaq	-0x100(%rbp), %rdx
               	leaq	-0x1(%rax), %rsi
               	movl	(%rdx,%rsi,4), %edx
               	cmpl	%edx, %ecx
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
