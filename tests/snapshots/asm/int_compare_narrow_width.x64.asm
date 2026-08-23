
int_compare_narrow_width.x64:	file format elf64-x86-64

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
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	movslq	%eax, %r8
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movslq	%eax, %rdi
               	movq	(%rsi), %rax
               	movl	%eax, %eax
               	movq	(%rcx), %rcx
               	movl	%ecx, %r9d
               	testl	%r8d, %r8d
               	jl	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpl	%edi, %r8d
               	jl	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpl	%r8d, %edi
               	jg	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpl	$0x80000001, %r8d       # imm = 0x80000001
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpl	%edi, %r8d
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpl	$0xc, %edi
               	setle	%dl
               	movzbq	%dl, %rdx
               	testl	%edx, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpl	$0xc, %edi
               	setge	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %ecx
               	movl	%r9d, %edx
               	cmpl	%edx, %ecx
               	ja	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80000000, %r11d      # imm = 0x80000000
               	cmpl	%r11d, %ecx
               	ja	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	%edi, %edx
               	movl	%eax, %ecx
               	cmpl	%ecx, %edx
               	jbe	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80000001, %r11d      # imm = 0x80000001
               	movq	%rcx, %rax
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	(%rsi), %rax
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rax
               	jg	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	imulq	%rdi, %rax
               	cmpl	$0x90, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	shlq	$0x4, %rax
               	cmpl	$0xc0, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%r8, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	cmpq	$-0x12492492, %rax      # imm = 0xEDB6DB6E
               	je	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movsbq	%al, %rax
               	movq	(%rcx), %rdx
               	andq	$0xff, %rdx
               	movq	(%rcx), %rcx
               	movswq	%cx, %r12
               	testl	%eax, %eax
               	setl	%sil
               	movzbq	%sil, %rsi
               	testl	%esi, %esi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpl	$-0x6e, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rcx
               	andq	$0xff, %rcx
               	testl	%ecx, %ecx
               	setg	%bl
               	movzbq	%bl, %rbx
               	testl	%ebx, %ebx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rcx, %rsi
               	xorq	$0x92, %rsi
               	movl	%esi, %esi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpl	%r12d, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movl	$0x20, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	<rip>, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rcx,%rcx,2), %rdx
               	movl	%edx, (%rsi,%rcx,4)
               	incq	%rax
               	cmpl	$0x14, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax,%rdi,4), %rax
               	cmpl	$0x24, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	%r9d, %ecx
               	movslq	%ecx, %rcx
               	movslq	(%rax,%rcx,4), %rax
               	cmpl	$0x24, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x5(%rdi), %rax
               	movslq	%eax, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax,%rcx,4), %rdx
               	addq	%r8, %rdx
               	movl	%edx, (%rax,%rcx,4)
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x80000016, %eax       # imm = 0x80000016
               	je	<addr>
               	movl	$0x23, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movabsq	$-0x1, %rcx
               	movq	%rcx, %rdx
               	cmpl	$-0x5, %edi
               	jge	<addr>
               	movq	%rcx, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x4924924924924925, %rax # imm = 0x4924924924924925
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%r8, %rax
               	imulq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	sarq	%rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	cmpq	$-0x12492492, %rax      # imm = 0xEDB6DB6E
               	je	<addr>
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpl	$0x5, %edi
               	jle	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
