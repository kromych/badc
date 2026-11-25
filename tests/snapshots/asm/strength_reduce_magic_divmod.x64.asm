
strength_reduce_magic_divmod.x64:	file format elf64-x86-64

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
               	subq	$0x1b8, %rsp            # imm = 0x1B8
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
               	movq	$0x3b9aca07, <rip> # imm = 0x3B9ACA07
                                                # <addr>
               	movq	$-0x3b9aca07, <rip> # imm = 0xC46535F9
                                                # <addr>
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, <rip> # <addr>
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
               	leaq	<rip>, %rcx # <addr>
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x1069e6a57e06665d, %rax # imm = 0x1069E6A57E06665D
               	movq	%rax, <rip> # <addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rcx,%rax,8), %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rcx,%rax,8), %rsi
               	movl	%esi, (%rdx,%rax,4)
               	leaq	<rip>, %rdx # <addr>
               	movq	(%rcx,%rax,8), %rsi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x14, %eax
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, 0x8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x8(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x8(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x5, 0x10(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x21, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x10(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	nopl	(%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	leaq	(%rdi,%rdi,4), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x10(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	nopl	(%rax)
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x6, 0x18(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x2aaaaaab, %rsi, %rax # imm = 0x2AAAAAAB
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x18(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x6, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x18(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x7, 0x20(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x20(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x20(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xa, 0x28(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x28(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x28(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x64, 0x30(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x51eb851f, %rsi, %rax # imm = 0x51EB851F
               	sarq	$0x25, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x30(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	nop
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x64, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x30(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x3e8, 0x38(%rsp)      # imm = 0x3E8
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x10624dd3, %rsi, %rax # imm = 0x10624DD3
               	sarq	$0x26, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x38(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x38(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xffff, 0x40(%rsp)     # imm = 0xFFFF
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	movl	$0x80008001, %eax       # imm = 0x80008001
               	imulq	%rsi, %rax
               	sarq	$0x2f, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x40(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0xffff, %rdi, %rax     # imm = 0xFFFF
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x40(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x10001, 0x48(%rsp)    # imm = 0x10001
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x7fff8001, %rsi, %rax # imm = 0x7FFF8001
               	sarq	$0x2f, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x48(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x10001, %rdi, %rax    # imm = 0x10001
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x48(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x7fffffff, 0x50(%rsp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x50(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	nop
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x7fffffff, %rdi, %rax # imm = 0x7FFFFFFF
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x50(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffffd, 0x58(%rsp) # imm = 0xFFFFFFFD
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r8
               	negq	%r8
               	movl	0x58(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	nopl	(%rax,%rax)
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x3, %rax, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x58(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffff9, 0x60(%rsp) # imm = 0xFFFFFFF9
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	movl	$0x92492493, %eax       # imm = 0x92492493
               	imulq	%rsi, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r8
               	negq	%r8
               	movl	0x60(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x7, %rax, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x60(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xffffff9c, 0x68(%rsp) # imm = 0xFFFFFF9C
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	imulq	$0x51eb851f, %rsi, %rax # imm = 0x51EB851F
               	sarq	$0x25, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r8
               	negq	%r8
               	movl	0x68(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x64, %rax, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x68(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	nopl	(%rax,%rax)
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x80000000, 0x70(%rsp) # imm = 0x80000000
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	movq	%rsi, %r8
               	shrq	$0x21, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %rax
               	sarq	$0x1f, %rax
               	movq	%rax, %r9
               	negq	%r9
               	movl	0x70(%rsp), %eax
               	movq	%rax, %r10
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	nopl	(%rax)
               	cmpl	%eax, %r9d
               	jne	<addr>
               	andq	$0x7fffffff, %rdi       # imm = 0x7FFFFFFF
               	subq	%r8, %rdi
               	movl	0x70(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	nop
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, 0x78(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	movl	0x78(%rsp), %edi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	nopl	(%rax)
               	cmpl	%eax, %esi
               	jne	<addr>
               	movl	0x78(%rsp), %edi
               	movl	%esi, %eax
               	cltd
               	idivl	%edi
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x8, 0x80(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	movq	%rsi, %r8
               	shrq	$0x3d, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %r9
               	sarq	$0x3, %r9
               	movl	0x80(%rsp), %eax
               	movq	%rax, %r10
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%eax, %r9d
               	jne	<addr>
               	andq	$0x7, %rdi
               	subq	%r8, %rdi
               	movl	0x80(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffff8, 0x88(%rsp) # imm = 0xFFFFFFF8
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	movq	%rsi, %r8
               	shrq	$0x3d, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %rax
               	sarq	$0x3, %rax
               	movq	%rax, %r9
               	negq	%r9
               	movl	0x88(%rsp), %eax
               	movq	%rax, %r10
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%eax, %r9d
               	jne	<addr>
               	andq	$0x7, %rdi
               	subq	%r8, %rdi
               	movl	0x88(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x40000000, 0x90(%rsp) # imm = 0x40000000
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rax,%rcx,4), %rsi
               	movq	%rsi, %r8
               	shrq	$0x22, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %r9
               	sarq	$0x1e, %r9
               	movl	0x90(%rsp), %eax
               	movq	%rax, %r10
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%eax, %r9d
               	jne	<addr>
               	andq	$0x3fffffff, %rdi       # imm = 0x3FFFFFFF
               	subq	%r8, %rdi
               	movl	0x90(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x3, 0x98(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	movl	$0xaaaaaaab, %edi       # imm = 0xAAAAAAAB
               	imulq	%rsi, %rdi
               	shrq	$0x21, %rdi
               	movl	0x98(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x98(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x7, 0xa0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	imulq	$0x24924925, %rsi, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	shrq	%rdx
               	leaq	(%rdx,%rax), %rdi
               	shrq	$0x2, %rdi
               	movl	0xa0(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xa0(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	nopw	(%rax,%rax)
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xa, 0xa8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	%rax
               	imulq	$0x66666667, %rax, %rdi # imm = 0x66666667
               	shrq	$0x21, %rdi
               	movl	0xa8(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	nopw	(%rax,%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xa8(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xe, 0xb0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	%rax
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	imulq	%rax, %rdi
               	shrq	$0x22, %rdi
               	movl	0xb0(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0xe, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xb0(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x64, 0xb8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	$0x2, %rax
               	imulq	$0xa3d70a4, %rax, %rdi  # imm = 0xA3D70A4
               	shrq	$0x20, %rdi
               	movl	0xb8(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	nop
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x64, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xb8(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x3e8, 0xc0(%rsp)      # imm = 0x3E8
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	$0x3, %rax
               	imulq	$0x10624dd3, %rax, %rdi # imm = 0x10624DD3
               	shrq	$0x23, %rdi
               	movl	0xc0(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	nop
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xc0(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x7fffffff, 0xc8(%rsp) # imm = 0x7FFFFFFF
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	leaq	(%rsi,%rsi,2), %rax
               	shrq	$0x20, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	shrq	%rdx
               	leaq	(%rdx,%rax), %rdi
               	shrq	$0x1e, %rdi
               	movl	0xc8(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x7fffffff, %rdi, %rax # imm = 0x7FFFFFFF
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xc8(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x80000001, 0xd0(%rsp) # imm = 0x80000001
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	cmpl	$0x80000001, %esi       # imm = 0x80000001
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	0xd0(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	movl	$0x80000001, %eax       # imm = 0x80000001
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xd0(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffffb, 0xd8(%rsp) # imm = 0xFFFFFFFB
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	cmpl	$-0x5, %esi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	0xd8(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	nopl	(%rax,%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	movl	$0xfffffffb, %eax       # imm = 0xFFFFFFFB
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xd8(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, 0xe0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	movl	0xe0(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	cmpl	%eax, %esi
               	jne	<addr>
               	movl	0xe0(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	nop
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x10, 0xe8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax,%rcx,4), %esi
               	movq	%rsi, %rdi
               	shrq	$0x4, %rdi
               	movl	0xe8(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%eax, %edi
               	jne	<addr>
               	movq	%rsi, %rdi
               	andq	$0xf, %rdi
               	movl	0xe8(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x3, 0xf0(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0xf0(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0xf0(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x7, 0xf8(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0xf8(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	nop
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0xf8(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0xa, 0x100(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x2, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x100(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x100(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	nopl	(%rax,%rax)
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x3e8, 0x108(%rsp)     # imm = 0x3E8
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x20c49ba5e353f7cf, %rdi # imm = 0x20C49BA5E353F7CF
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x7, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x108(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x108(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x3b9aca07, 0x110(%rsp) # imm = 0x3B9ACA07
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	imulq	%rdi
               	leaq	(%rdx,%rsi), %rax
               	sarq	$0x1d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	0x110(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x3b9aca07, %rdi, %rax # imm = 0x3B9ACA07
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x110(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, 0x118(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x4000000000000001, %rdi # imm = 0x4000000000000001
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x3d, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x118(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	nopl	(%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x118(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$-0x3, 0x120(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	%rdi, %r8
               	negq	%r8
               	movq	0x120(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x3, %rax, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x120(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$-0x7, 0x128(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	%rdi, %r8
               	negq	%r8
               	movq	0x128(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x7, %rax, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x128(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$-0x3b9aca07, 0x130(%rsp) # imm = 0xC46535F9
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	imulq	%rdi
               	leaq	(%rdx,%rsi), %rdi
               	sarq	$0x1d, %rdi
               	movq	%rdi, %r8
               	shrq	$0x3f, %r8
               	leaq	(%rdi,%r8), %rax
               	movq	%rax, %r9
               	negq	%r9
               	movq	0x130(%rsp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	leaq	(%rdi,%r8), %rax
               	negq	%rax
               	imulq	$-0x3b9aca07, %rax, %rax # imm = 0xC46535F9
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x130(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	nopw	(%rax,%rax)
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, 0x138(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rdi
               	sarq	$0x3f, %rdi
               	shrq	%rdi
               	leaq	(%rsi,%rdi), %r8
               	movq	%r8, %rax
               	sarq	$0x3f, %rax
               	movq	%rax, %r9
               	negq	%r9
               	movq	0x138(%rsp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	andq	%r11, %r8
               	subq	%rdi, %r8
               	movq	0x138(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	nopw	(%rax,%rax)
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x1, 0x140(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movq	0x140(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	0x140(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x400, 0x148(%rsp)     # imm = 0x400
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	shrq	$0x36, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %r9
               	sarq	$0xa, %r9
               	movq	0x148(%rsp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	subq	%r8, %rdi
               	movq	0x148(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$-0x400, 0x150(%rsp)    # imm = 0xFC00
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	shrq	$0x36, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %rax
               	sarq	$0xa, %rax
               	movq	%rax, %r9
               	negq	%r9
               	movq	0x150(%rsp), %rax
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	subq	%r8, %rdi
               	movq	0x150(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x3, 0x158(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x5555555555555555, %rdi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	0x158(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x158(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x7, 0x160(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	leaq	(%rax,%rdx), %rdi
               	shrq	$0x2, %rdi
               	movq	0x160(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	nopw	(%rax,%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x160(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0xa, 0x168(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	0x168(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x168(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0xe, 0x170(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	0x170(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	nopw	(%rax,%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xe, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x170(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x3b9aca07, 0x178(%rsp) # imm = 0x3B9ACA07
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	$0x1d, %rdi
               	movq	0x178(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x3b9aca07, %rdi, %rax # imm = 0x3B9ACA07
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x178(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	movq	%rax, 0x180(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$-0x7fffffffffffffff, %r11 # imm = 0x8000000000000001
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	0x180(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	nop
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	imulq	%rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x180(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$-0x5, 0x188(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	cmpq	$-0x5, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	0x188(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$-0x5, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x188(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x1, 0x190(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movq	0x190(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	0x190(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	nopw	(%rax,%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movq	$0x400, 0x198(%rsp)     # imm = 0x400
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rcx,8), %rsi
               	movq	%rsi, %rdi
               	shrq	$0xa, %rdi
               	movq	0x198(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	%rsi, %rdi
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	movq	0x198(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nop
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	$0xffffcfc7, 0x1a0(%rsp) # imm = 0xFFFFCFC7
               	movabsq	$-0x11f71fb04cb, %rax   # imm = 0xFFFFFEE08E04FB35
               	movq	%rax, 0x1a8(%rsp)
               	movl	0x1a0(%rsp), %ecx
               	xorl	%eax, %eax
               	negq	%rcx
               	cmpl	$0x3039, %ecx           # imm = 0x3039
               	jne	<addr>
               	movl	0x1a0(%rsp), %ecx
               	movq	0x1a8(%rsp), %rcx
               	negq	%rcx
               	movabsq	$0x11f71fb04cb, %r11    # imm = 0x11F71FB04CB
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	0x1a8(%rsp), %rcx
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	$0x5b, %eax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	$0x5a, %eax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1b8, %rsp            # imm = 0x1B8
               	retq
