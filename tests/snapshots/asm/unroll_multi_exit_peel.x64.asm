
unroll_multi_exit_peel.x64:	file format elf64-x86-64

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

<scan_peeled>:
               	xorl	%ecx, %ecx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	movq	%rcx, %rax
               	negq	%rax
               	subq	%rcx, %rax
               	decq	%rax
               	retq
               	movq	<rip>, %rax # <addr>
               	imulq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rdx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rdx, %rsi
               	addq	%rsi, %rax
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<main>:
               	subq	$0x38, %rsp
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	%rcx, %rax
               	shlq	%rax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	shlq	%rcx
               	leaq	(%rax,%rcx), %rdx
               	movl	$0x2, %ecx
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rax
               	shlq	%rax
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	cmpq	$0x10e14, %rax          # imm = 0x10E14
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x870c, %rax           # imm = 0x870C
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movl	$0x2, %edx
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rdx), %r11
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	movq	%rax, %rcx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	(%rsi,%rax,8), %rdx
               	movq	(%r8,%rax,8), %r10
               	imulq	%r10, %rdx
               	addq	%rdx, %rcx
               	movq	(%rdi,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movl	$0x2, %edx
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rdx), %r11
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	movq	%rax, %rcx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	(%rsi,%rax,8), %rdx
               	movq	(%r8,%rax,8), %r10
               	imulq	%r10, %rdx
               	addq	%rdx, %rcx
               	movq	(%rdi,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	movl	$0x2, %edx
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rcx
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rdx), %r11
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	movq	%rax, %rcx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	(%rsi,%rax,8), %rdx
               	movq	(%r8,%rax,8), %r10
               	imulq	%r10, %rdx
               	addq	%rdx, %rcx
               	movq	(%rdi,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	shlq	%rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	leaq	(%rcx,%rdx), %rsi
               	movl	$0x2, %edx
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rdx), %r11
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	movq	%rax, %rcx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	(%rsi,%rax,8), %rdx
               	movq	(%r8,%rax,8), %r10
               	imulq	%r10, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	(%rdi,%rax,8), %rdx
               	nop
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r11
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	shlq	%rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	leaq	(%rcx,%rdx), %rsi
               	movl	$0x2, %edx
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rdx), %r11
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	movq	%rax, %rcx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	(%rsi,%rax,8), %rdx
               	movq	(%r8,%rax,8), %r10
               	imulq	%r10, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	(%rdi,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r11
               	jne	<addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdx # <addr>
               	imulq	%rdx, %rcx
               	shlq	%rcx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	leaq	(%rcx,%rdx), %rsi
               	movl	$0x2, %edx
               	movq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jge	<addr>
               	shlq	$0x3, %rcx
               	leaq	(%rcx,%rdx), %r11
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	movq	%rax, %rcx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	movq	(%rsi,%rax,8), %rdx
               	movq	(%r8,%rax,8), %r10
               	imulq	%r10, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	(%rdi,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r11
               	jne	<addr>
               	movl	$0x3, %eax
               	movl	$0x1, %ecx
               	movq	%rcx, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	xorl	%edx, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	imulq	%r8, %rdi
               	imulq	%rax, %rdi
               	addq	%rdi, %rsi
               	movq	<rip>, %rdi # <addr>
               	testq	%rdi, %rdi
               	jge	<addr>
               	shlq	$0x3, %rsi
               	leaq	(%rsi,%rcx), %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %r10d # <addr>
               	movq	%rdx, %rcx
               	cmpl	%r10d, %edx
               	jge	<addr>
               	movq	(%rdi,%rdx,8), %rsi
               	movq	(%r9,%rdx,8), %r11
               	imulq	%r11, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rcx
               	movq	(%r8,%rdx,8), %rsi
               	nopl	(%rax,%rax)
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rdx
               	cmpl	%r10d, %edx
               	jl	<addr>
               	shlq	$0x3, %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, %r10
               	movq	0x28(%rsp), %rcx
               	cmpq	%r10, %rcx
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	imulq	%rax, %rdx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movl	$0x2, %esi
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %r8 # <addr>
               	imulq	%r8, %rdx
               	imulq	%rax, %rdx
               	addq	%rdi, %rdx
               	movq	<rip>, %rdi # <addr>
               	testq	%rdi, %rdi
               	jge	<addr>
               	shlq	$0x3, %rdx
               	leaq	(%rdx,%rsi), %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %r10d # <addr>
               	movq	%rcx, %rdx
               	cmpl	%r10d, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rsi
               	movq	(%r9,%rcx,8), %r11
               	imulq	%r11, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rdx
               	movq	(%r8,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	%r10d, %ecx
               	jl	<addr>
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %r10
               	movq	0x28(%rsp), %rcx
               	cmpq	%r10, %rcx
               	jne	<addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	imulq	%rax, %rdx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	imulq	%rax, %rsi
               	leaq	(%rdx,%rsi), %rdi
               	movl	$0x2, %esi
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %r8 # <addr>
               	imulq	%r8, %rdx
               	imulq	%rax, %rdx
               	addq	%rdi, %rdx
               	movq	<rip>, %rdi # <addr>
               	testq	%rdi, %rdi
               	jge	<addr>
               	shlq	$0x3, %rdx
               	leaq	(%rdx,%rsi), %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %r10d # <addr>
               	movq	%rcx, %rdx
               	cmpl	%r10d, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rsi
               	movq	(%r9,%rcx,8), %r11
               	imulq	%r11, %rsi
               	imulq	%rax, %rsi
               	addq	%rsi, %rdx
               	movq	(%r8,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r10d, %ecx
               	jl	<addr>
               	shlq	$0x3, %rdx
               	leaq	(%rdx,%rcx), %rax
               	movq	%rax, %r10
               	movq	0x28(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movq	$-0x2, %rdx
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movq	%rdi, 0x18(%rsp)
               	movq	%r8, 0x10(%rsp)
               	movq	%r9, 0x8(%rsp)
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	%rdx, (%rsp)
               	movq	%rdx, %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movq	0x18(%rsp), %rdi
               	movq	0x10(%rsp), %r8
               	movq	0x8(%rsp), %r9
               	movq	(%rsp), %rdx
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %r10
               	testq	%r10, %r10
               	jl	<addr>
               	movq	(%r9,%rcx,8), %r11
               	imulq	%r10, %r11
               	addq	%r11, %rsi
               	movq	(%r8,%rcx,8), %r10
               	cmpq	%rdx, %r10
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	movq	0x28(%rsp), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	%rdx, (%rsp)
               	movq	%rdx, %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movq	0x18(%rsp), %rdi
               	movq	0x10(%rsp), %r8
               	movq	0x8(%rsp), %r9
               	movq	(%rsp), %rdx
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %r10
               	testq	%r10, %r10
               	jl	<addr>
               	movq	(%r9,%rcx,8), %r11
               	imulq	%r10, %r11
               	addq	%r11, %rsi
               	movq	(%r8,%rcx,8), %r10
               	cmpq	%rdx, %r10
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	nopw	%cs:(%rax,%rax)
               	nop
               	movq	0x28(%rsp), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	%rdx, (%rsp)
               	movq	%rdx, %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movq	0x18(%rsp), %rdi
               	movq	0x10(%rsp), %r8
               	movq	0x8(%rsp), %r9
               	movq	(%rsp), %rdx
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %r10
               	testq	%r10, %r10
               	jl	<addr>
               	movq	(%r9,%rcx,8), %r11
               	imulq	%r10, %r11
               	addq	%r11, %rsi
               	movq	(%r8,%rcx,8), %r10
               	cmpq	%rdx, %r10
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	nopw	%cs:(%rax,%rax)
               	nop
               	movq	0x28(%rsp), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0xa, <rip> # <addr>
               	movq	$0x64, <rip> # <addr>
               	movq	$0x3e8, <rip> # imm = 0x3E8
                                                # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	%rdx, (%rsp)
               	movq	%rdx, %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	movq	0x18(%rsp), %rdi
               	movq	0x10(%rsp), %r8
               	movq	0x8(%rsp), %r9
               	movq	(%rsp), %rdx
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %r10
               	testq	%r10, %r10
               	jl	<addr>
               	movq	(%r9,%rcx,8), %r11
               	imulq	%r10, %r11
               	addq	%r11, %rsi
               	movq	(%r8,%rcx,8), %r10
               	nopl	(%rax)
               	cmpq	%rdx, %r10
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	shlq	$0x3, %rsi
               	addq	%rsi, %rcx
               	nopw	%cs:(%rax,%rax)
               	nop
               	movq	0x28(%rsp), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	negq	%rsi
               	subq	%rcx, %rsi
               	leaq	-0x1(%rsi), %rcx
               	jmp	<addr>
               	negq	%rsi
               	subq	%rcx, %rsi
               	leaq	-0x1(%rsi), %rcx
               	jmp	<addr>
               	negq	%rsi
               	subq	%rcx, %rsi
               	leaq	-0x1(%rsi), %rcx
               	jmp	<addr>
               	negq	%rsi
               	subq	%rcx, %rsi
               	leaq	-0x1(%rsi), %rcx
               	jmp	<addr>
               	incq	%rdx
               	cmpl	$0x2, %edx
               	jle	<addr>
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x9, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x8, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x7, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x3, %esi
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	imulq	%r8, %rdi
               	imulq	%rax, %rdi
               	addq	%rdi, %rdx
               	movq	<rip>, %rdi # <addr>
               	testq	%rdi, %rdi
               	jl	<addr>
               	movl	$0x4, %esi
               	jmp	<addr>
               	movl	$0x3, %esi
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	imulq	%r8, %rdi
               	imulq	%rax, %rdi
               	addq	%rdi, %rdx
               	movq	<rip>, %rdi # <addr>
               	testq	%rdi, %rdi
               	jl	<addr>
               	movl	$0x4, %esi
               	jmp	<addr>
               	movl	$0x2, %ecx
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	imulq	%r8, %rdi
               	imulq	%rax, %rdi
               	addq	%rdi, %rsi
               	movq	<rip>, %rdi # <addr>
               	testq	%rdi, %rdi
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdi # <addr>
               	movq	<rip>, %r8 # <addr>
               	imulq	%r8, %rdi
               	imulq	%rax, %rdi
               	addq	%rdi, %rsi
               	movq	<rip>, %rdi # <addr>
               	testq	%rdi, %rdi
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x3, %edx
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdi # <addr>
               	imulq	%rdi, %rsi
               	addq	%rsi, %rcx
               	movq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rsi # <addr>
               	imulq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
