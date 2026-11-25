
strength_reduce_inlined_divmod.x64:	file format elf64-x86-64

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

<ints>:
               	subq	$0xc8, %rsp
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0xa, %r8d
               	movl	%r8d, 0x18(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x18(%rsp), %r10d
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	0x18(%rsp), %edi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x92492493, %r9d       # imm = 0x92492493
               	leaq	<rip>, %r10 # <addr>
               	movl	$0x7, %r8d
               	movl	%r8d, 0x20(%rsp)
               	movq	(%r10,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	imulq	%r9, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x20(%rsp), %r11d
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	0x20(%rsp), %edi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x92492493, %r9d       # imm = 0x92492493
               	leaq	<rip>, %r10 # <addr>
               	movq	$-0x7, %rdi
               	movl	%edi, 0x28(%rsp)
               	movq	(%r10,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	imulq	%r9, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%r8, %r11
               	negq	%r11
               	movl	0x28(%rsp), %eax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%eax, %r11d
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	movq	%r8, %rax
               	negq	%rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x28(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, 0x30(%rsp)
               	movq	(%rdi,%rcx,8), %rax
               	movq	%rax, %rsi
               	movl	0x30(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	nopl	(%rax,%rax)
               	cmpl	%eax, %esi
               	jne	<addr>
               	movl	0x30(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xffffffff, 0x38(%rsp) # imm = 0xFFFFFFFF
               	movq	(%rdi,%rcx,8), %rax
               	movq	%rax, %rsi
               	nopw	%cs:(%rax,%rax)
               	cmpl	$0x80000000, %esi       # imm = 0x80000000
               	je	<addr>
               	movq	%rsi, %r8
               	negq	%r8
               	movl	0x38(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	nopl	(%rax)
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movl	0x38(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	testl	%edx, %edx
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x2, 0x40(%rsp)
               	movq	(%r8,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rsi,%rax), %rdi
               	sarq	%rdi
               	movl	0x40(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %edi
               	jne	<addr>
               	shlq	%rdi
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	movl	0x40(%rsp), %edi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	cmpl	%edx, %r9d
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movq	$-0x2, %r8
               	movl	%r8d, 0x48(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rsi,%rax), %rdi
               	sarq	%rdi
               	movq	%rdi, %r10
               	negq	%r10
               	movl	0x48(%rsp), %r11d
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	cmpl	%eax, %r10d
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	%r8, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x48(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x400, 0x50(%rsp)      # imm = 0x400
               	movq	(%r8,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x36, %rax
               	leaq	(%rsi,%rax), %rdi
               	sarq	$0xa, %rdi
               	movl	0x50(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %edi
               	jne	<addr>
               	shlq	$0xa, %rdi
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	movl	0x50(%rsp), %edi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	cmpl	%edx, %r9d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x7fffffff, %r8d       # imm = 0x7FFFFFFF
               	movl	%r8d, 0x58(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x58(%rsp), %r10d
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	nopl	(%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movl	0x58(%rsp), %edi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	nopl	(%rax,%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movq	$-0x80000000, %r8       # imm = 0x80000000
               	movl	%r8d, 0x60(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x21, %rax
               	leaq	(%rsi,%rax), %rdi
               	sarq	$0x1f, %rdi
               	movq	%rdi, %r10
               	negq	%r10
               	movl	0x60(%rsp), %r11d
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	nopl	(%rax)
               	cmpl	%eax, %r10d
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	%r8, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x60(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movq	$-0x7fffffff, %rdi      # imm = 0x80000001
               	movl	%edi, 0x68(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %r8
               	movq	%r8, %r10
               	negq	%r10
               	movl	0x68(%rsp), %r11d
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	cmpl	%eax, %r10d
               	jne	<addr>
               	movq	%r8, %rax
               	negq	%rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x68(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r10 # <addr>
               	movl	$0xa, %r9d
               	movl	%r9d, 0x70(%rsp)
               	movq	(%r10,%rcx,8), %rdi
               	movl	%edi, %r8d
               	movq	%r8, %rax
               	shrq	%rax
               	imulq	$0x66666667, %rax, %rsi # imm = 0x66666667
               	shrq	$0x21, %rsi
               	movl	0x70(%rsp), %r11d
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r11d
               	cmpl	%eax, %esi
               	jne	<addr>
               	imulq	%r9, %rsi
               	subq	%rsi, %r8
               	movl	0x70(%rsp), %esi
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r10 # <addr>
               	movl	$0x7, %r9d
               	movl	%r9d, 0x78(%rsp)
               	movq	(%r10,%rcx,8), %r8
               	movl	%r8d, %edi
               	imulq	$0x24924925, %rdi, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	shrq	%rdx
               	leaq	(%rdx,%rax), %rsi
               	shrq	$0x2, %rsi
               	movl	0x78(%rsp), %r11d
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r11d
               	cmpl	%eax, %esi
               	jne	<addr>
               	imulq	%r9, %rsi
               	subq	%rsi, %rdi
               	movl	0x78(%rsp), %esi
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, 0x80(%rsp)
               	movq	(%rdi,%rcx,8), %rsi
               	movl	%esi, %r8d
               	movl	0x80(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movl	0x80(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x40, 0x88(%rsp)
               	movq	(%r9,%rcx,8), %rsi
               	movl	%esi, %r8d
               	movq	%r8, %rdi
               	shrq	$0x6, %rdi
               	movl	0x88(%rsp), %r10d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	nopl	(%rax,%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	shlq	$0x6, %rdi
               	subq	%rdi, %r8
               	movl	0x88(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	nopl	(%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x80000000, 0x90(%rsp) # imm = 0x80000000
               	movq	(%r9,%rcx,8), %rsi
               	movl	%esi, %r8d
               	movq	%r8, %rdi
               	shrq	$0x1f, %rdi
               	movl	0x90(%rsp), %r10d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	cmpl	%eax, %edi
               	jne	<addr>
               	shlq	$0x1f, %rdi
               	subq	%rdi, %r8
               	movl	0x90(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x80000001, %r10d      # imm = 0x80000001
               	leaq	<rip>, %r11 # <addr>
               	movl	$0x80000001, %r9d       # imm = 0x80000001
               	movl	%r9d, 0x98(%rsp)
               	movq	(%r11,%rcx,8), %rsi
               	movl	%esi, %r8d
               	cmpq	%r10, %r8
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	0x98(%rsp), %eax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	nopl	(%rax)
               	cmpl	%eax, %edi
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	imulq	%r9, %rdi
               	subq	%rdi, %r8
               	movl	0x98(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffffe, %r10d      # imm = 0xFFFFFFFE
               	leaq	<rip>, %r11 # <addr>
               	movl	$0xfffffffe, %r9d       # imm = 0xFFFFFFFE
               	movl	%r9d, 0xa0(%rsp)
               	movq	(%r11,%rcx,8), %rsi
               	movl	%esi, %r8d
               	cmpq	%r10, %r8
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	0xa0(%rsp), %eax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	cmpl	%eax, %edi
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	imulq	%r9, %rdi
               	subq	%rdi, %r8
               	movl	0xa0(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	leaq	<rip>, %r11 # <addr>
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	movl	%r9d, 0xa8(%rsp)
               	movq	(%r11,%rcx,8), %rsi
               	movl	%esi, %r8d
               	cmpq	%r10, %r8
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	0xa8(%rsp), %eax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	nopl	(%rax)
               	cmpl	%eax, %edi
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	imulq	%r9, %rdi
               	subq	%rdi, %r8
               	movl	0xa8(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffffd, %r9d       # imm = 0xFFFFFFFD
               	leaq	<rip>, %r10 # <addr>
               	movl	$0xfffffffd, 0xb0(%rsp) # imm = 0xFFFFFFFD
               	movq	(%r10,%rcx,8), %rsi
               	movl	%esi, %r8d
               	cmpq	%r9, %r8
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	0xb0(%rsp), %r11d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r11d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r9, %rdi
               	subq	%rdi, %r8
               	movl	0xb0(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	nopl	(%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	leaq	<rip>, %r10 # <addr>
               	movl	$0xffffffff, 0xb8(%rsp) # imm = 0xFFFFFFFF
               	movq	(%r10,%rcx,8), %rsi
               	movl	%esi, %r8d
               	cmpq	%r9, %r8
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	0xb8(%rsp), %r11d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r11d
               	nopl	(%rax,%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r9, %rdi
               	subq	%rdi, %r8
               	movl	0xb8(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	nopl	(%rax,%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq

<wides>:
               	subq	$0xc8, %rsp
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %r8d
               	movq	%r8, 0x10(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	cmpq	%r9, %rsi
               	je	<addr>
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x2, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x10(%rsp), %r11
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	nopw	(%rax,%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0x10(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	nopl	(%rax)
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x3e8, %rdi           # imm = 0xFC18
               	movq	%rdi, 0x18(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	cmpq	%r9, %rsi
               	je	<addr>
               	movabsq	$0x20c49ba5e353f7cf, %r8 # imm = 0x20C49BA5E353F7CF
               	movq	%rsi, %rax
               	imulq	%r8
               	sarq	$0x7, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %r8
               	movq	%r8, %r11
               	negq	%r11
               	movq	0x18(%rsp), %rax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r11
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	movq	%r8, %rax
               	negq	%rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x18(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %rdi # imm = 0x5555555555555555
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0x1, 0x20(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movq	0x20(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	0x20(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x1, 0x28(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movq	%rsi, %r9
               	negq	%r9
               	movq	0x28(%rsp), %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	0x28(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	nop
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r8 # imm = 0x5555555555555555
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$0x1000, 0x30(%rsp)     # imm = 0x1000
               	movq	(%r9,%rcx,8), %rsi
               	cmpq	%r8, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x34, %rax
               	leaq	(%rsi,%rax), %rdi
               	sarq	$0xc, %rdi
               	movq	0x30(%rsp), %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %rdi
               	jne	<addr>
               	shlq	$0xc, %rdi
               	movq	%rsi, %r10
               	subq	%rdi, %r10
               	movq	0x30(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r10
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$0x100000001, %r8       # imm = 0x100000001
               	movq	%r8, 0x38(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	cmpq	%r9, %rsi
               	je	<addr>
               	movabsq	$0x7fffffff80000001, %rdi # imm = 0x7FFFFFFF80000001
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x1f, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x38(%rsp), %r11
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0x38(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	nopl	(%rax)
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r8, 0x40(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	cmpq	%r9, %rsi
               	je	<addr>
               	movabsq	$0x4000000000000001, %rdi # imm = 0x4000000000000001
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x3d, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x40(%rsp), %r11
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	nopl	(%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0x40(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	nopl	(%rax)
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%esi, %esi
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rsi
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movq	%r8, 0x48(%rsp)
               	movq	(%r10,%rsi,8), %rcx
               	cmpq	%r9, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	%rax
               	leaq	(%rcx,%rax), %rdi
               	sarq	$0x3f, %rdi
               	movq	%rdi, %r11
               	negq	%r11
               	movq	0x48(%rsp), %rax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	nop
               	cmpq	%rax, %r11
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	%r8, %rax
               	movq	%rcx, %rdi
               	subq	%rax, %rdi
               	movq	0x48(%rsp), %r8
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %r8d
               	movq	%r8, 0x50(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	nopl	(%rax,%rax)
               	cmpq	%r9, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	0x50(%rsp), %r11
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r11
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0x50(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%esi, %esi
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rsi
               	nopw	(%rax,%rax)
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movl	$0x7, %r8d
               	movq	%r8, 0x58(%rsp)
               	movq	(%r10,%rsi,8), %rcx
               	nopl	(%rax,%rax)
               	cmpq	%r9, %rcx
               	je	<addr>
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rcx, %rax
               	mulq	%rdi
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	leaq	(%rax,%rdx), %rdi
               	shrq	$0x2, %rdi
               	movq	0x58(%rsp), %r11
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r11
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rcx, %r8
               	subq	%rdi, %r8
               	movq	0x58(%rsp), %rdi
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r8 # imm = 0x5555555555555555
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, 0x60(%rsp)
               	movq	(%r9,%rcx,8), %rsi
               	nopl	(%rax)
               	cmpq	%r8, %rsi
               	je	<addr>
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	movq	0x60(%rsp), %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	nopl	(%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	shlq	$0x20, %rdi
               	movq	%rsi, %r10
               	subq	%rdi, %r10
               	movq	0x60(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	nopl	(%rax)
               	cmpq	%rdx, %r10
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	movq	%r8, 0x68(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	cmpq	%r9, %rsi
               	je	<addr>
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	movq	0x68(%rsp), %r11
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r11
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0x68(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	nopl	(%rax)
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$-0x7fffffffffffffff, %r9 # imm = 0x8000000000000001
               	movabsq	$0x5555555555555555, %r10 # imm = 0x5555555555555555
               	leaq	<rip>, %r11 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movabsq	$-0x7fffffffffffffff, %r8 # imm = 0x8000000000000001
               	movq	%r8, 0x70(%rsp)
               	movq	(%r11,%rcx,8), %rsi
               	cmpq	%r10, %rsi
               	je	<addr>
               	cmpq	%r9, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	0x70(%rsp), %rax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	nopw	(%rax,%rax)
               	cmpq	%rax, %rdi
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0x70(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r8 # imm = 0x5555555555555555
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x1, 0x78(%rsp)
               	movq	(%r9,%rcx,8), %rsi
               	cmpq	%r8, %rsi
               	je	<addr>
               	cmpq	$-0x1, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	0x78(%rsp), %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	cmpq	%rax, %rdi
               	jne	<addr>
               	addq	%rsi, %rdi
               	movq	0x78(%rsp), %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	nopw	(%rax,%rax)
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x3, %r8
               	movq	%r8, 0x80(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	cmpq	%r9, %rsi
               	je	<addr>
               	cmpq	$-0x3, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	0x80(%rsp), %r11
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r11
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0x80(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %r8d
               	movq	%r8, 0x88(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	nopl	(%rax,%rax)
               	cmpq	%r9, %rsi
               	je	<addr>
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x2, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x88(%rsp), %r11
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0x88(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x7, %rdi
               	movq	%rdi, 0x90(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	nop
               	cmpq	%r9, %rsi
               	je	<addr>
               	movabsq	$0x4924924924924925, %r8 # imm = 0x4924924924924925
               	movq	%rsi, %rax
               	imulq	%r8
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %r8
               	movq	%r8, %r11
               	negq	%r11
               	movq	0x90(%rsp), %rax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r11
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	movq	%r8, %rax
               	negq	%rax
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x90(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%esi, %esi
               	movabsq	$0x5555555555555555, %r8 # imm = 0x5555555555555555
               	leaq	<rip>, %r9 # <addr>
               	jmp	<addr>
               	incq	%rsi
               	nopl	(%rax,%rax)
               	cmpl	$0x18, %esi
               	jge	<addr>
               	movq	$0x40000000, 0x98(%rsp) # imm = 0x40000000
               	movq	(%r9,%rsi,8), %rcx
               	nopl	(%rax)
               	cmpq	%r8, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x22, %rax
               	leaq	(%rcx,%rax), %rdi
               	sarq	$0x1e, %rdi
               	movq	0x98(%rsp), %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %rdi
               	jne	<addr>
               	shlq	$0x1e, %rdi
               	movq	%rcx, %r10
               	subq	%rdi, %r10
               	movq	0x98(%rsp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r10
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	leaq	<rip>, %r8 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x1, 0xa0(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	nopl	(%rax)
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movq	%rsi, %r9
               	negq	%r9
               	movq	0xa0(%rsp), %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	nopl	(%rax,%rax)
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	0xa0(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0xa, %r8d
               	movq	%r8, 0xa8(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	nopl	(%rax)
               	cmpq	%r9, %rsi
               	je	<addr>
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	0xa8(%rsp), %r11
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r11
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0xa8(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movl	$0x80000001, %r8d       # imm = 0x80000001
               	movq	%r8, 0xb0(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	nopl	(%rax,%rax)
               	cmpq	%r9, %rsi
               	je	<addr>
               	movabsq	$0x3fffffff80000001, %rdi # imm = 0x3FFFFFFF80000001
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	$0x1d, %rdi
               	movq	0xb0(%rsp), %r11
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r11
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0xb0(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x5555555555555555, %r9 # imm = 0x5555555555555555
               	leaq	<rip>, %r10 # <addr>
               	jmp	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x18, %ecx
               	jge	<addr>
               	movq	$-0x3, %r8
               	movq	%r8, 0xb8(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	nopl	(%rax)
               	cmpq	%r9, %rsi
               	je	<addr>
               	cmpq	$-0x3, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	0xb8(%rsp), %r11
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r11
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0xb8(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xc8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xc8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xc8, %rsp
               	retq

<converted>:
               	subq	$0xa8, %rsp
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x3, %r8d
               	movb	%r8b, 0x18(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movsbq	%al, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movsbq	0x18(%rsp), %r10
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movsbq	0x18(%rsp), %rdi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movq	$-0x80, %r8
               	movb	%r8b, 0x20(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movsbq	%al, %rsi
               	movq	%rsi, %rax
               	shrq	$0x39, %rax
               	leaq	(%rsi,%rax), %rdi
               	sarq	$0x7, %rdi
               	movq	%rdi, %r10
               	negq	%r10
               	movsbq	0x20(%rsp), %r11
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	cmpl	%eax, %r10d
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	%r8, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movsbq	0x20(%rsp), %r8
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movb	$-0x1, 0x28(%rsp)
               	movq	(%rdi,%rcx,8), %rax
               	movsbq	%al, %rsi
               	movq	%rsi, %r8
               	negq	%r8
               	movsbq	0x28(%rsp), %r9
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movsbq	0x28(%rsp), %r8
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x3, %r8d
               	movb	%r8b, 0x30(%rsp)
               	movq	(%r9,%rcx,8), %rsi
               	andq	$0xff, %rsi
               	imulq	$0x55555556, %rsi, %rdi # imm = 0x55555556
               	shrq	$0x20, %rdi
               	movzbq	0x30(%rsp), %r10
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movzbq	0x30(%rsp), %rdi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0xff, %r8d
               	movb	%r8b, 0x38(%rsp)
               	movq	(%r9,%rcx,8), %rsi
               	andq	$0xff, %rsi
               	imulq	$0x1010102, %rsi, %rdi  # imm = 0x1010102
               	shrq	$0x20, %rdi
               	movzbq	0x38(%rsp), %r10
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	nop
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movzbq	0x38(%rsp), %rdi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	nopl	(%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0xa, %r8d
               	movw	%r8w, 0x40(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movswq	%ax, %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movswq	0x40(%rsp), %r10
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	nop
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movswq	0x40(%rsp), %rdi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	nopl	(%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movq	$-0x8000, %r8           # imm = 0x8000
               	movw	%r8w, 0x48(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movswq	%ax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x31, %rax
               	leaq	(%rsi,%rax), %rdi
               	sarq	$0xf, %rdi
               	movq	%rdi, %r10
               	negq	%r10
               	movswq	0x48(%rsp), %r11
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	nop
               	cmpl	%eax, %r10d
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	%r8, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movswq	0x48(%rsp), %r8
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xaaaaaaab, %r10d      # imm = 0xAAAAAAAB
               	leaq	<rip>, %r11 # <addr>
               	movl	$0x3, %r9d
               	movl	%r9d, 0x50(%rsp)
               	movq	(%r11,%rcx,8), %rdi
               	movl	%edi, %r8d
               	movq	%r8, %rsi
               	imulq	%r10, %rsi
               	shrq	$0x21, %rsi
               	movl	0x50(%rsp), %eax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	cmpl	%eax, %esi
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	imulq	%r9, %rsi
               	subq	%rsi, %r8
               	movl	0x50(%rsp), %esi
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x80000000, 0x58(%rsp) # imm = 0x80000000
               	movq	(%r9,%rcx,8), %rsi
               	movl	%esi, %r8d
               	movq	%r8, %rdi
               	shrq	$0x1f, %rdi
               	movl	0x58(%rsp), %r10d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	cmpl	%eax, %edi
               	jne	<addr>
               	shlq	$0x1f, %rdi
               	subq	%rdi, %r8
               	movl	0x58(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffffd, %r9d       # imm = 0xFFFFFFFD
               	leaq	<rip>, %r10 # <addr>
               	movl	$0xfffffffd, 0x60(%rsp) # imm = 0xFFFFFFFD
               	movq	(%r10,%rcx,8), %rsi
               	movl	%esi, %r8d
               	cmpq	%r9, %r8
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	0x60(%rsp), %r11d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r11d
               	nop
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r9, %rdi
               	subq	%rdi, %r8
               	movl	0x60(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	nopl	(%rax)
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x3, %r8d
               	movq	%r8, 0x68(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movslq	%eax, %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	0x68(%rsp), %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	nop
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0x68(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movq	$-0x1, 0x70(%rsp)
               	movq	(%rdi,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %r8
               	negq	%r8
               	movq	0x70(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	0x70(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movabsq	$0x100000000, %rax      # imm = 0x100000000
               	movq	%rax, 0x78(%rsp)
               	movq	(%rdi,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	0x78(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x78(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movq	$-0x80000000, %r8       # imm = 0x80000000
               	movq	%r8, 0x80(%rsp)
               	movq	(%r9,%rcx,8), %rax
               	movslq	%eax, %rsi
               	movq	%rsi, %rax
               	shrq	$0x21, %rax
               	leaq	(%rsi,%rax), %rdi
               	sarq	$0x1f, %rdi
               	movq	%rdi, %r10
               	negq	%r10
               	movq	0x80(%rsp), %r11
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	cmpq	%rax, %r10
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	%r8, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x80(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r10 # <addr>
               	movl	$0x7, %r8d
               	movq	%r8, 0x88(%rsp)
               	movq	(%r10,%rcx,8), %r9
               	movl	%r9d, %esi
               	imulq	$0x24924925, %rsi, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	shrq	%rdx
               	leaq	(%rdx,%rax), %rdi
               	movq	%rdi, %r11
               	shrq	$0x2, %r11
               	movq	0x88(%rsp), %rax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r11
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	shrq	$0x2, %rdi
               	imulq	%r8, %rdi
               	subq	%rdi, %rsi
               	movl	%r9d, %edi
               	movq	0x88(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	nopl	(%rax)
               	cmpl	%edx, %esi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r11 # <addr>
               	movq	$-0x7, %r8
               	movq	%r8, 0x90(%rsp)
               	movq	(%r11,%rcx,8), %r9
               	movl	%r9d, %edi
               	movabsq	$0x4924924924924925, %rsi # imm = 0x4924924924924925
               	movq	%rdi, %rax
               	imulq	%rsi
               	movq	%rdx, %rsi
               	sarq	%rsi
               	movq	%rsi, %r10
               	shrq	$0x3f, %r10
               	leaq	(%rsi,%r10), %rax
               	negq	%rax
               	movq	0x90(%rsp), %rdx
               	movq	%r10, 0x8(%rsp)
               	movq	%rdx, %r10
               	movq	%rax, -0x18(%rsp)
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdx
               	movq	-0x18(%rsp), %rax
               	cmpq	%rdx, %rax
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	leaq	(%rsi,%r10), %rax
               	negq	%rax
               	imulq	%r8, %rax
               	subq	%rax, %rdi
               	movl	%r9d, %esi
               	movq	0x90(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	nopw	(%rax,%rax)
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	leaq	<rip>, %r10 # <addr>
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	movq	%r8, 0x98(%rsp)
               	movq	(%r10,%rcx,8), %rax
               	movl	%eax, %esi
               	cmpq	%r9, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	0x98(%rsp), %r11
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r8
               	subq	%rdi, %r8
               	movq	0x98(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x18, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0xa8, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0xa8, %rsp
               	retq

<fixed>:
               	movslq	%edi, %rdi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rdi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	leaq	(%rax,%rcx), %rdx
               	movl	%edi, %eax
               	movq	%rax, %rcx
               	shrq	$0x3, %rcx
               	imulq	$0x10624dd3, %rcx, %rcx # imm = 0x10624DD3
               	shrq	$0x23, %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	subq	%rcx, %rax
               	addq	%rdx, %rax
               	retq

<main>:
               	subq	$0x30, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	$0x0, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$-0x2, <rip> # <addr>
               	movq	$0x7fffffff, <rip> # imm = 0x7FFFFFFF
                                                # <addr>
               	movq	$-0x80000000, <rip> # imm = 0x80000000
                                                # <addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, <rip> # <addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, <rip> # <addr>
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movq	%rax, <rip> # <addr>
               	movq	$0x7f, <rip> # <addr>
               	movq	$-0x80, <rip> # <addr>
               	movq	$0xff, <rip> # <addr>
               	movq	$-0x8000, <rip> # imm = 0x8000
                                                # <addr>
               	movq	$0xffff, <rip> # imm = 0xFFFF
                                                # <addr>
               	movabsq	$0x2ceaee21bf46bc00, %rax # imm = 0x2CEAEE21BF46BC00
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x557f8ab2e5e572b1, %rax # imm = 0xAA80754D1A1A8D4F
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x4c3b6fb592d876ce, %rax # imm = 0xB3C4904A6D278932
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x439630bd897b92e7, %rax # imm = 0xBC69CF4276846D19
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x377b2fd56a5b15b4, %rax # imm = 0x377B2FD56A5B15B4
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x64d815deeaf29df3, %rax # imm = 0x64D815DEEAF29DF3
               	movq	%rax, <rip> # <addr>
               	movabsq	$-0x991eff24d282dfa, %rax # imm = 0xF66E100DB2D7D206
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x1069e6a57e06665d, %rax # imm = 0x1069E6A57E06665D
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x30, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x30, %rsp
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x30, %rsp
               	retq
               	xorl	%ebx, %ebx
               	movl	%ebx, 0x28(%rsp)
               	movl	$0x7, 0x30(%rsp)
               	movl	$0x3e8, 0x38(%rsp)      # imm = 0x3E8
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	%rbx, %r12
               	jmp	<addr>
               	incq	%r12
               	cmpl	$0x18, %r12d
               	jge	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%r12,8), %rdi
               	movslq	%edi, %r13
               	movl	$0x7, %esi
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	0x30(%rsp), %esi
               	movl	%r13d, %eax
               	cltd
               	idivl	%esi
               	movq	%rax, %rsi
               	movl	0x38(%rsp), %edi
               	movl	%r13d, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	leaq	(%rsi,%rdx), %rax
               	cmpl	%eax, %ecx
               	jne	<addr>
               	movslq	0x28(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%ecx, %ecx
               	movq	%r13, %rax
               	cqto
               	idivq	%rcx
               	addq	%r13, %rax
               	addq	%rax, %rbx
               	jmp	<addr>
               	movl	<rip>, %ebx # <addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x30, %rsp
               	retq
