
if_converted_arms.x64:	file format elf64-x86-64

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

<makeq>:
               	movq	%rdi, %rax
               	negq	%rax
               	movl	%edi, %ecx
               	shlq	$0x20, %rax
               	orq	%rcx, %rax
               	retq

<narrow_compare_in_arm>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movl	$0x7, %edi
               	callq	<addr>
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	xorl	%ecx, %ecx
               	cmpl	$0x7, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x12, %rbx
               	cmovneq	%rcx, %rax
               	cmpl	$-0x7, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rax, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<late_operands>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	0x10(%rbp), %rax
               	movswq	0x28(%rbp), %rbx
               	movslq	0x30(%rbp), %r12
               	leaq	(%rbx,%rbx,2), %rbx
               	decq	%r12
               	movsbq	0x20(%rbp), %r13
               	testl	%r13d, %r13d
               	cmovleq	%r12, %rbx
               	leaq	(%rbx,%rbx,4), %rbx
               	movslq	%ebx, %rbx
               	addq	%rbx, %rax
               	movsbq	0x20(%rbp), %rbx
               	addq	%rbx, %rax
               	addq	%rdi, %rax
               	addq	%rsi, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<swap_if>:
               	testb	$0x1, %dl
               	movq	%rdi, %rax
               	cmovneq	%rsi, %rax
               	cmovneq	%rdi, %rsi
               	imulq	$0xa, %rax, %rax
               	addq	%rsi, %rax
               	retq

<diamond>:
               	movq	%rsi, %rax
               	subq	%rdi, %rax
               	movq	%rdi, %rcx
               	subq	%rsi, %rcx
               	cmpq	%rsi, %rdi
               	cmovgeq	%rcx, %rax
               	retq

<count_below>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%esi, %eax
               	jge	<addr>
               	leaq	0x1(%rcx), %r8
               	movl	(%rdi,%rax,4), %r9d
               	cmpl	%edx, %r9d
               	cmovlq	%r8, %rcx
               	incq	%rax
               	cmpl	%esi, %eax
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<inc_unless>:
               	leaq	0x1(%rdi), %rax
               	testl	%esi, %esi
               	cmovneq	%rdi, %rax
               	retq

<scale>:
               	testl	%edi, %edi
               	je	<addr>
               	movabsq	$0x3ff8000000000000, %r11 # imm = 0x3FF8000000000000
               	movq	%r11, %xmm1
               	vmulsd	%xmm0, %xmm1, %xmm0
               	retq
               	movabsq	$0x3f50624dd2f1a9fc, %r11 # imm = 0x3F50624DD2F1A9FC
               	movq	%r11, %xmm1
               	jmp	<addr>

<umax>:
               	cmpl	%esi, %edi
               	movq	%rsi, %rax
               	cmovaq	%rdi, %rax
               	retq

<pick_ne>:
               	ucomisd	%xmm1, %xmm0
               	movq	%rsi, %rax
               	cmovneq	%rdi, %rax
               	cmovpq	%rdi, %rax
               	retq

<pick_eq>:
               	ucomisd	%xmm1, %xmm0
               	movq	%rdi, %rax
               	cmovneq	%rsi, %rax
               	cmovpq	%rsi, %rax
               	retq

<pick_lt>:
               	comisd	%xmm0, %xmm1
               	movq	%rsi, %rax
               	cmovaq	%rdi, %rax
               	retq

<on_byte>:
               	cmpb	$0x0, (%rdi)
               	movq	%rdx, %rax
               	cmovneq	%rsi, %rax
               	retq

<on_int_zero>:
               	cmpl	$0x0, (%rdi)
               	movq	%rsi, %rax
               	cmovneq	%rdx, %rax
               	retq

<on_long>:
               	cmpq	$0x0, (%rdi)
               	movq	%rsi, %rax
               	cmovneq	%rdx, %rax
               	retq

<on_param>:
               	testl	%edi, %edi
               	movq	%rsi, %rax
               	cmovneq	%rdx, %rax
               	retq

<load_then_store>:
               	cmpb	$0x0, (%rdi)
               	movb	$0x0, (%rdi)
               	movq	%rdx, %rax
               	cmovneq	%rsi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movl	$0x12, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x11, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	subq	$0x30, %rsp
               	movq	$0x10, (%rsp)
               	movq	%rdi, 0x8(%rsp)
               	movq	$0x78, 0x10(%rsp)
               	movq	$-0x12c, 0x18(%rsp)     # imm = 0xFED4
               	movq	$0x11170, 0x20(%rsp)    # imm = 0x11170
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	addq	$0x30, %rsp
               	cmpq	$-0x110c, %rax          # imm = 0xEEF4
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	subq	$0x30, %rsp
               	movq	$0x10, (%rsp)
               	movq	%rdi, 0x8(%rsp)
               	movq	$-0x2, 0x10(%rsp)
               	movq	$-0x12c, 0x18(%rsp)     # imm = 0xFED4
               	movq	$0x11170, 0x20(%rsp)    # imm = 0x11170
               	movq	%rdi, %rsi
               	movq	%rdi, %r9
               	movq	%rdi, %r8
               	movq	%rdi, %rcx
               	movq	%rdi, %rdx
               	callq	<addr>
               	addq	$0x30, %rsp
               	cmpq	$0x55739, %rax          # imm = 0x55739
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0xa, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movq	$-0x5, %rdi
               	movq	%rdi, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x8, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x8, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x5, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	jne	<addr>
               	movl	$0x5, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	$-0x1, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movl	$0x1, %edi
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%edi, %edi
               	movabsq	$0x408f400000000000, %rax # imm = 0x408F400000000000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0x80000000, %edi       # imm = 0x80000000
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	jne	<addr>
               	movl	$0x5, %edi
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	callq	<addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	$0x0, -0x8(%rbp)
               	movsd	-0x8(%rbp), %xmm0
               	movsd	-0x8(%rbp), %xmm1
               	vdivsd	%xmm1, %xmm0, %xmm14
               	movsd	%xmm14, 0x8(%rsp)
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	movq	%rax, %xmm0
               	movq	%rax, %xmm1
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	movsd	0x8(%rsp), %xmm0
               	movq	%rax, %xmm1
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	movq	%rax, %xmm0
               	movq	%rax, %xmm1
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	movsd	0x8(%rsp), %xmm0
               	movsd	0x8(%rsp), %xmm1
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	movq	%rax, %xmm0
               	movq	%rcx, %xmm1
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	movsd	0x8(%rsp), %xmm0
               	movq	%rax, %xmm1
               	callq	<addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movl	$0x5, %edi
               	movl	$0x7, %esi
               	movq	%rax, %xmm0
               	movsd	0x8(%rsp), %xmm1
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	leaq	-0x50(%rbp), %rax
               	leaq	(%rax,%rcx), %rdi
               	movl	$0x5, %esi
               	movl	$0x7, %edx
               	movq	%rcx, (%rsp)
               	callq	<addr>
               	movq	(%rsp), %rcx
               	movl	$0x5, %edx
               	movl	$0x7, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	-0x48(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	$0x5, %esi
               	movl	$0x7, %edx
               	movq	%rcx, (%rsp)
               	callq	<addr>
               	movq	(%rsp), %rcx
               	movl	$0x7, %edx
               	movl	$0x5, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	$0x5, %esi
               	movl	$0x7, %edx
               	movq	%rcx, (%rsp)
               	callq	<addr>
               	movq	(%rsp), %rcx
               	movl	$0x7, %edx
               	movl	$0x5, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	$0x5, %esi
               	movl	$0x7, %edx
               	movq	%rcx, (%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movq	(%rsp), %rcx
               	movl	$0x7, %edx
               	movl	$0x5, %esi
               	testq	%rcx, %rcx
               	cmoveq	%rsi, %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	movb	$0x3, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x5, %esi
               	movl	$0x7, %edx
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	cmpb	$0x0, -0x40(%rbp)
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	$0x12, %eax
               	leave
               	retq
               	movl	$0x11, %eax
               	leave
               	retq
               	movl	$0x10, %eax
               	leave
               	retq
