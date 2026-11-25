
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
               	subq	$0x1c8, %rsp            # imm = 0x1C8
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
               	movq	%rax, <rip> # <addr>
               	movabsq	$0x1069e6a57e06665d, %rax # imm = 0x1069E6A57E06665D
               	movq	%rax, <rip> # <addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	(%rcx,%rax,8), %r8
               	movq	%r8, (%rdx,%rax,8)
               	movq	(%rcx,%rax,8), %r8
               	movl	%r8d, (%rsi,%rax,4)
               	movq	(%rcx,%rax,8), %r8
               	movl	%r8d, (%rdi,%rax,4)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x14, %eax
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x3, 0x18(%rsp)
               	movslq	(%r8,%rcx,4), %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x18(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %edi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x18(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x5, 0x20(%rsp)
               	movslq	(%r8,%rcx,4), %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x21, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x20(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	nopl	(%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	leaq	(%rdi,%rdi,4), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x20(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
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
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x6, 0x28(%rsp)
               	movslq	(%r8,%rcx,4), %rsi
               	imulq	$0x2aaaaaab, %rsi, %rax # imm = 0x2AAAAAAB
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x28(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x6, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x28(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x7, 0x30(%rsp)
               	movslq	(%r9,%rcx,4), %rsi
               	movq	%rsi, %rax
               	imulq	%r8, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x30(%rsp), %r10d
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x30(%rsp), %r10d
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0xa, 0x38(%rsp)
               	movslq	(%r8,%rcx,4), %rsi
               	imulq	$0x66666667, %rsi, %rax # imm = 0x66666667
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x38(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x38(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x64, 0x40(%rsp)
               	movslq	(%r8,%rcx,4), %rsi
               	imulq	$0x51eb851f, %rsi, %rax # imm = 0x51EB851F
               	sarq	$0x25, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x40(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	nop
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x64, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x40(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x3e8, 0x48(%rsp)      # imm = 0x3E8
               	movslq	(%r8,%rcx,4), %rsi
               	imulq	$0x10624dd3, %rsi, %rax # imm = 0x10624DD3
               	sarq	$0x26, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x48(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x48(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x80008001, %r8d       # imm = 0x80008001
               	leaq	<rip>, %r9 # <addr>
               	movl	$0xffff, 0x50(%rsp)     # imm = 0xFFFF
               	movslq	(%r9,%rcx,4), %rsi
               	movq	%rsi, %rax
               	imulq	%r8, %rax
               	sarq	$0x2f, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x50(%rsp), %r10d
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0xffff, %rdi, %rax     # imm = 0xFFFF
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x50(%rsp), %r10d
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x10001, 0x58(%rsp)    # imm = 0x10001
               	movslq	(%r8,%rcx,4), %rsi
               	imulq	$0x7fff8001, %rsi, %rax # imm = 0x7FFF8001
               	sarq	$0x2f, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x58(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x10001, %rdi, %rax    # imm = 0x10001
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x58(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x7fffffff, 0x60(%rsp) # imm = 0x7FFFFFFF
               	movslq	(%r8,%rcx,4), %rsi
               	imulq	$0x40000001, %rsi, %rax # imm = 0x40000001
               	sarq	$0x3d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movl	0x60(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	nop
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x7fffffff, %rdi, %rax # imm = 0x7FFFFFFF
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x60(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0xfffffffd, 0x68(%rsp) # imm = 0xFFFFFFFD
               	movslq	(%r8,%rcx,4), %rsi
               	imulq	$0x55555556, %rsi, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r9
               	negq	%r9
               	movl	0x68(%rsp), %r10d
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	nopl	(%rax,%rax)
               	cmpl	%eax, %r9d
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x3, %rax, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x68(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	leaq	<rip>, %r9 # <addr>
               	movl	$0xfffffff9, 0x70(%rsp) # imm = 0xFFFFFFF9
               	movslq	(%r9,%rcx,4), %rsi
               	movq	%rsi, %rax
               	imulq	%r8, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r10
               	negq	%r10
               	movl	0x70(%rsp), %r11d
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	cmpl	%eax, %r10d
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x7, %rax, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x70(%rsp), %r10d
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
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
               	leaq	<rip>, %r8 # <addr>
               	movl	$0xffffff9c, 0x78(%rsp) # imm = 0xFFFFFF9C
               	movslq	(%r8,%rcx,4), %rsi
               	imulq	$0x51eb851f, %rsi, %rax # imm = 0x51EB851F
               	sarq	$0x25, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r9
               	negq	%r9
               	movl	0x78(%rsp), %r10d
               	movl	%esi, %eax
               	cltd
               	idivl	%r10d
               	cmpl	%eax, %r9d
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x64, %rax, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0x78(%rsp), %r9d
               	movl	%esi, %eax
               	cltd
               	idivl	%r9d
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
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x80000000, 0x80(%rsp) # imm = 0x80000000
               	movslq	(%r9,%rcx,4), %rsi
               	movq	%rsi, %r8
               	shrq	$0x21, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %rax
               	sarq	$0x1f, %rax
               	movq	%rax, %r10
               	negq	%r10
               	movl	0x80(%rsp), %r11d
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	cmpl	%eax, %r10d
               	jne	<addr>
               	andq	$0x7fffffff, %rdi       # imm = 0x7FFFFFFF
               	subq	%r8, %rdi
               	movl	0x80(%rsp), %r8d
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
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, 0x88(%rsp)
               	movl	(%rdi,%rcx,4), %esi
               	movl	0x88(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	cmpl	%eax, %esi
               	jne	<addr>
               	movl	0x88(%rsp), %r8d
               	movl	%esi, %eax
               	cltd
               	idivl	%r8d
               	nopl	(%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x8, 0x90(%rsp)
               	movslq	(%r9,%rcx,4), %rsi
               	movq	%rsi, %r8
               	shrq	$0x3d, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %r10
               	sarq	$0x3, %r10
               	movl	0x90(%rsp), %r11d
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	nopw	(%rax,%rax)
               	cmpl	%eax, %r10d
               	jne	<addr>
               	andq	$0x7, %rdi
               	subq	%r8, %rdi
               	movl	0x90(%rsp), %r8d
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
               	leaq	<rip>, %r9 # <addr>
               	movl	$0xfffffff8, 0x98(%rsp) # imm = 0xFFFFFFF8
               	movslq	(%r9,%rcx,4), %rsi
               	movq	%rsi, %r8
               	shrq	$0x3d, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %rax
               	sarq	$0x3, %rax
               	movq	%rax, %r10
               	negq	%r10
               	movl	0x98(%rsp), %r11d
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	nopl	(%rax)
               	cmpl	%eax, %r10d
               	jne	<addr>
               	andq	$0x7, %rdi
               	subq	%r8, %rdi
               	movl	0x98(%rsp), %r8d
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
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x40000000, 0xa0(%rsp) # imm = 0x40000000
               	movslq	(%r9,%rcx,4), %rsi
               	movq	%rsi, %r8
               	shrq	$0x22, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %r10
               	sarq	$0x1e, %r10
               	movl	0xa0(%rsp), %r11d
               	movl	%esi, %eax
               	cltd
               	idivl	%r11d
               	nopw	(%rax,%rax)
               	cmpl	%eax, %r10d
               	jne	<addr>
               	andq	$0x3fffffff, %rdi       # imm = 0x3FFFFFFF
               	subq	%r8, %rdi
               	movl	0xa0(%rsp), %r8d
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
               	movl	$0xaaaaaaab, %r8d       # imm = 0xAAAAAAAB
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x3, 0xa8(%rsp)
               	movl	(%r9,%rcx,4), %esi
               	movq	%rsi, %rdi
               	imulq	%r8, %rdi
               	shrq	$0x21, %rdi
               	movl	0xa8(%rsp), %r10d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	nopl	(%rax,%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xa8(%rsp), %r10d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x7, 0xb0(%rsp)
               	movl	(%r8,%rcx,4), %esi
               	imulq	$0x24924925, %rsi, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	shrq	%rdx
               	leaq	(%rdx,%rax), %rdi
               	shrq	$0x2, %rdi
               	movl	0xb0(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xb0(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0xa, 0xb8(%rsp)
               	movl	(%r8,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	%rax
               	imulq	$0x66666667, %rax, %rdi # imm = 0x66666667
               	shrq	$0x21, %rdi
               	movl	0xb8(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xb8(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	leaq	<rip>, %r9 # <addr>
               	movl	$0xe, 0xc0(%rsp)
               	movl	(%r9,%rcx,4), %esi
               	movq	%rsi, %rdi
               	shrq	%rdi
               	imulq	%r8, %rdi
               	shrq	$0x22, %rdi
               	movl	0xc0(%rsp), %r10d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0xe, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xc0(%rsp), %r10d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x64, 0xc8(%rsp)
               	movl	(%r8,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	$0x2, %rax
               	imulq	$0xa3d70a4, %rax, %rdi  # imm = 0xA3D70A4
               	shrq	$0x20, %rdi
               	movl	0xc8(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	nopl	(%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x64, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xc8(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x3e8, 0xd0(%rsp)      # imm = 0x3E8
               	movl	(%r8,%rcx,4), %esi
               	movq	%rsi, %rax
               	shrq	$0x3, %rax
               	imulq	$0x10624dd3, %rax, %rdi # imm = 0x10624DD3
               	shrq	$0x23, %rdi
               	movl	0xd0(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	nopl	(%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xd0(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movl	$0x7fffffff, 0xd8(%rsp) # imm = 0x7FFFFFFF
               	movl	(%r8,%rcx,4), %esi
               	leaq	(%rsi,%rsi,2), %rax
               	shrq	$0x20, %rax
               	movq	%rsi, %rdx
               	subq	%rax, %rdx
               	shrq	%rdx
               	leaq	(%rdx,%rax), %rdi
               	shrq	$0x1e, %rdi
               	movl	0xd8(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	$0x7fffffff, %rdi, %rax # imm = 0x7FFFFFFF
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movl	0xd8(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x80000001, %r8d       # imm = 0x80000001
               	leaq	<rip>, %r9 # <addr>
               	movl	$0x80000001, 0xe0(%rsp) # imm = 0x80000001
               	movl	(%r9,%rcx,4), %esi
               	cmpl	%r8d, %esi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	0xe0(%rsp), %r10d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r10
               	subq	%rdi, %r10
               	movl	0xe0(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	cmpl	%edx, %r10d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0xfffffffb, %r8d       # imm = 0xFFFFFFFB
               	leaq	<rip>, %r9 # <addr>
               	movl	$0xfffffffb, 0xe8(%rsp) # imm = 0xFFFFFFFB
               	movl	(%r9,%rcx,4), %esi
               	cmpl	%r8d, %esi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movl	0xe8(%rsp), %r10d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	nopl	(%rax)
               	cmpl	%eax, %edi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r10
               	subq	%rdi, %r10
               	movl	0xe8(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	nop
               	cmpl	%edx, %r10d
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, 0xf0(%rsp)
               	movl	(%rdi,%rcx,4), %esi
               	movl	0xf0(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	cmpl	%eax, %esi
               	jne	<addr>
               	movl	0xf0(%rsp), %r8d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	nopl	(%rax)
               	testl	%edx, %edx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x10, 0xf8(%rsp)
               	movl	(%rdi,%rcx,4), %esi
               	movq	%rsi, %r8
               	shrq	$0x4, %r8
               	movl	0xf8(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%eax, %r8d
               	jne	<addr>
               	movq	%rsi, %r8
               	andq	$0xf, %r8
               	movl	0xf8(%rsp), %r9d
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	cmpl	%edx, %r8d
               	jne	<addr>
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	$0x3, 0x100(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x100(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	nopl	(%rax,%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x100(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	$0x7, 0x108(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x108(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x108(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	$0xa, 0x110(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x2, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x110(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x110(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	$0x3e8, 0x118(%rsp)     # imm = 0x3E8
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$0x20c49ba5e353f7cf, %rdi # imm = 0x20C49BA5E353F7CF
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x7, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x118(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x118(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
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
               	leaq	<rip>, %r8 # <addr>
               	movq	$0x3b9aca07, 0x120(%rsp) # imm = 0x3B9ACA07
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	imulq	%rdi
               	leaq	(%rdx,%rsi), %rax
               	sarq	$0x1d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	0x120(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x3b9aca07, %rdi, %rax # imm = 0x3B9ACA07
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x120(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x7fffffffffffffff, %r8 # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	<rip>, %r9 # <addr>
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, 0x128(%rsp)
               	movq	(%r9,%rcx,8), %rsi
               	movabsq	$0x4000000000000001, %rdi # imm = 0x4000000000000001
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	$0x3d, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	0x128(%rsp), %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r10
               	subq	%rdi, %r10
               	movq	0x128(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	cmpq	%rdx, %r10
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	$-0x3, 0x130(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$0x5555555555555556, %rdi # imm = 0x5555555555555556
               	movq	%rsi, %rax
               	imulq	%rdi
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	%rdi, %r9
               	negq	%r9
               	movq	0x130(%rsp), %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x3, %rax, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x130(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	$-0x7, 0x138(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	movq	%rsi, %rax
               	imulq	%rdi
               	sarq	%rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rdi
               	movq	%rdi, %r9
               	negq	%r9
               	movq	0x138(%rsp), %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x7, %rax, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x138(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
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
               	leaq	<rip>, %r8 # <addr>
               	movq	$-0x3b9aca07, 0x140(%rsp) # imm = 0xC46535F9
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	imulq	%rdi
               	leaq	(%rdx,%rsi), %rax
               	sarq	$0x1d, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rdi
               	movq	%rdi, %r9
               	negq	%r9
               	movq	0x140(%rsp), %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	%rdi, %rax
               	negq	%rax
               	imulq	$-0x3b9aca07, %rax, %rax # imm = 0xC46535F9
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x140(%rsp), %r9
               	movq	%rsi, %rax
               	cqto
               	idivq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movabsq	$0x7fffffffffffffff, %r9 # imm = 0x7FFFFFFFFFFFFFFF
               	leaq	<rip>, %r10 # <addr>
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, 0x148(%rsp)
               	movq	(%r10,%rcx,8), %rsi
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	shrq	%r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %rax
               	sarq	$0x3f, %rax
               	movq	%rax, %r11
               	negq	%r11
               	movq	0x148(%rsp), %rax
               	movq	%r10, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	cqto
               	idivq	%r10
               	nopw	%cs:(%rax,%rax)
               	cmpq	%rax, %r11
               	movq	0x8(%rsp), %r10
               	jne	<addr>
               	andq	%r9, %rdi
               	subq	%r8, %rdi
               	movq	0x148(%rsp), %r8
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
               	leaq	<rip>, %rdi # <addr>
               	movq	$0x1, 0x150(%rsp)
               	movq	(%rdi,%rcx,8), %rsi
               	movq	0x150(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	0x150(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movq	$0x400, 0x158(%rsp)     # imm = 0x400
               	movq	(%r9,%rcx,8), %rsi
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	shrq	$0x36, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %r10
               	sarq	$0xa, %r10
               	movq	0x158(%rsp), %r11
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	cmpq	%rax, %r10
               	jne	<addr>
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	subq	%r8, %rdi
               	movq	0x158(%rsp), %r8
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r9 # <addr>
               	movq	$-0x400, 0x160(%rsp)    # imm = 0xFC00
               	movq	(%r9,%rcx,8), %rsi
               	movq	%rsi, %r8
               	sarq	$0x3f, %r8
               	shrq	$0x36, %r8
               	leaq	(%rsi,%r8), %rdi
               	movq	%rdi, %rax
               	sarq	$0xa, %rax
               	movq	%rax, %r10
               	negq	%r10
               	movq	0x160(%rsp), %r11
               	movq	%rsi, %rax
               	cqto
               	idivq	%r11
               	nopl	(%rax)
               	cmpq	%rax, %r10
               	jne	<addr>
               	andq	$0x3ff, %rdi            # imm = 0x3FF
               	subq	%r8, %rdi
               	movq	0x160(%rsp), %r8
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
               	leaq	<rip>, %r8 # <addr>
               	movq	$0x3, 0x168(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$-0x5555555555555555, %rdi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	0x168(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %rdi
               	jne	<addr>
               	leaq	(%rdi,%rdi,2), %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x168(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	$0x7, 0x170(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$0x2492492492492493, %rdi # imm = 0x2492492492492493
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	leaq	(%rax,%rdx), %rdi
               	shrq	$0x2, %rdi
               	movq	0x170(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	nopw	(%rax,%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x7, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x170(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	$0xa, 0x178(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x6666666666666667, %rdi # imm = 0x6666666666666667
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	0x178(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xa, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x178(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
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
               	leaq	<rip>, %r8 # <addr>
               	movq	$0xe, 0x180(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	movq	%rsi, %rax
               	shrq	%rax
               	movabsq	$0x4924924924924925, %rdi # imm = 0x4924924924924925
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	movq	0x180(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	nopw	(%rax,%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0xe, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x180(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	$0x3b9aca07, 0x188(%rsp) # imm = 0x3B9ACA07
               	movq	(%r8,%rcx,8), %rsi
               	movabsq	$-0x768fa0ceed5d701b, %rdi # imm = 0x89705F3112A28FE5
               	movq	%rsi, %rax
               	mulq	%rdi
               	movq	%rdx, %rdi
               	shrq	$0x1d, %rdi
               	movq	0x188(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$0x3b9aca07, %rdi, %rax # imm = 0x3B9ACA07
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x188(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
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
               	movabsq	$-0x7fffffffffffffff, %r8 # imm = 0x8000000000000001
               	leaq	<rip>, %r9 # <addr>
               	movabsq	$-0x7fffffffffffffff, %rax # imm = 0x8000000000000001
               	movq	%rax, 0x190(%rsp)
               	movq	(%r9,%rcx,8), %rsi
               	cmpq	%r8, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	0x190(%rsp), %r10
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	nopl	(%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	%r8, %rdi
               	movq	%rsi, %r10
               	subq	%rdi, %r10
               	movq	0x190(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	cmpq	%rdx, %r10
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %r8 # <addr>
               	movq	$-0x5, 0x198(%rsp)
               	movq	(%r8,%rcx,8), %rsi
               	cmpq	$-0x5, %rsi
               	setae	%dil
               	movzbq	%dil, %rdi
               	movq	0x198(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	nopl	(%rax,%rax)
               	cmpq	%rax, %rdi
               	jne	<addr>
               	imulq	$-0x5, %rdi, %rax
               	movq	%rsi, %rdi
               	subq	%rax, %rdi
               	movq	0x198(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movq	$0x1, 0x1a0(%rsp)
               	movq	(%rdi,%rcx,8), %rsi
               	movq	0x1a0(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	0x1a0(%rsp), %r8
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	testq	%rdx, %rdx
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movq	$0x400, 0x1a8(%rsp)     # imm = 0x400
               	movq	(%rdi,%rcx,8), %rsi
               	movq	%rsi, %r8
               	shrq	$0xa, %r8
               	movq	0x1a8(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	nopl	(%rax,%rax)
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	%rsi, %r8
               	andq	$0x3ff, %r8             # imm = 0x3FF
               	movq	0x1a8(%rsp), %r9
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	cmpq	%rdx, %r8
               	jne	<addr>
               	incq	%rcx
               	cmpl	$0x14, %ecx
               	jl	<addr>
               	movl	$0xffffcfc7, 0x1b0(%rsp) # imm = 0xFFFFCFC7
               	movabsq	$-0x11f71fb04cb, %rax   # imm = 0xFFFFFEE08E04FB35
               	movq	%rax, 0x1b8(%rsp)
               	movl	0x1b0(%rsp), %ecx
               	xorl	%eax, %eax
               	negq	%rcx
               	cmpl	$0x3039, %ecx           # imm = 0x3039
               	jne	<addr>
               	movl	0x1b0(%rsp), %ecx
               	movq	0x1b8(%rsp), %rcx
               	negq	%rcx
               	movabsq	$0x11f71fb04cb, %r11    # imm = 0x11F71FB04CB
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	0x1b8(%rsp), %rcx
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	$0x5b, %eax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	$0x5a, %eax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x64, %rax
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
               	movl	<rip>, %eax # <addr>
               	addq	$0x1c8, %rsp            # imm = 0x1C8
               	retq
