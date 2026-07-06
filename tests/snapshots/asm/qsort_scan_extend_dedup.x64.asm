
qsort_scan_extend_dedup.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<qs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %r12
               	movq	%rdx, %r13
               	movq	%rsi, %r8
               	movslq	%r8d, %r8
               	movslq	%r13d, %r13
               	cmpq	%r13, %r8
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	(%r8,%r13), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	$0x1, %rax
               	movslq	(%r12,%rax,4), %rax
               	movq	%r13, %rdx
               	movq	%r8, %rbx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rsi), %rbx
               	movslq	%ebx, %rsi
               	movslq	(%r12,%rsi,4), %rcx
               	cmpq	%rax, %rcx
               	jl	<addr>
               	jmp	<addr>
               	leaq	-0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	movslq	(%r12,%rcx,4), %rdi
               	cmpq	%rax, %rdi
               	jg	<addr>
               	cmpq	%rcx, %rsi
               	jg	<addr>
               	movslq	(%r12,%rsi,4), %rdi
               	movslq	(%r12,%rcx,4), %r9
               	movl	%r9d, (%r12,%rsi,4)
               	movl	%edi, (%r12,%rcx,4)
               	incq	%rbx
               	leaq	-0x1(%rcx), %rdx
               	jmp	<addr>
               	movslq	%ebx, %rcx
               	movslq	%edx, %rsi
               	cmpq	%rsi, %rcx
               	jle	<addr>
               	movq	%r12, %rdi
               	movq	%r8, %rsi
               	callq	<addr>
               	movq	%r12, %rdi
               	movq	%r13, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x130, %rsp            # imm = 0x130
               	movl	$0x3039, %ecx           # imm = 0x3039
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	%ecx, %ecx
               	imulq	$0x41c64e6d, %rcx, %rcx # imm = 0x41C64E6D
               	movl	%ecx, %ecx
               	addq	$0x3039, %rcx           # imm = 0x3039
               	movl	%ecx, %ecx
               	leaq	-0x100(%rbp), %rdi
               	movl	%ecx, %esi
               	shrq	$0x10, %rsi
               	subq	$0x4000, %rsi           # imm = 0x4000
               	movl	%esi, (%rdi,%rdx,4)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x40, %rdx
               	jl	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x3f, %edx
               	callq	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdx
               	movslq	(%rdx,%rcx,4), %rdi
               	leaq	-0x100(%rbp), %rdx
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	movslq	(%rdx,%rsi,4), %rdx
               	cmpq	%rdx, %rdi
               	jl	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x40, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
